import 'package:flutter/material.dart';
import 'tools/redirections.dart';
import 'tools/tools.dart';
import 'tools/authProvider.dart';
import 'package:provider/provider.dart';
import 'models/forumModel.dart';
import 'tools/secureStorage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  Future<List<Forum>> allForums() async {
    return await ForumApi().allForums();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<List<Forum>>(
        future: allForums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Erreur : ${snapshot.error}')),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Aucun forum trouvé')),
            );
          }

          List<Forum> forums = snapshot.data!;
          final authProvider = Provider.of<AuthProvider>(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Liste des forums'),
              backgroundColor: const Color(0xFFebddcc),
              leading: authProvider.isLoggedIn
                  ? Tools.icone(Icons.account_circle, "Mon compte", () async {
                await SecureStorage().logout();
                authProvider.logout();
                versForums(context);
              })
                  : Tools.icone(Icons.person_add_alt, "S'inscrire", () => versRegister(context)),
              actions: [
                if (authProvider.isLoggedIn && authProvider.isAdmin)
                  Tools.icone(Icons.add_circle_outline, "Ajouter un forum", () => versLogin(context)),
                if (!authProvider.isLoggedIn)
                  Tools.icone(Icons.login, "Se connecter", () => versLogin(context)),
              ],
            ),
            body: ListView.builder(
              itemCount: forums.length,
              itemBuilder: (context, index) {
                Forum forum = forums[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4E4E4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        title: Tools.text(forum.nom.toUpperCase(), TextAlign.center, 18),
                        onTap: () {
                          // Action quand on clique sur un forum
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
