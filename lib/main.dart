import 'package:flutter/material.dart';
import 'tools/redirections.dart';
import 'tools/tools.dart';
import 'tools/authProvider.dart';
import 'package:provider/provider.dart';
import 'models/forumModel.dart';
import 'tools/secureStorage.dart';
import 'controllers/mainController.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Forum',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeController(),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  final List<Forum> forums;
  final bool isLoading;
  final String? error;

  const Home({
    super.key,
    required this.forums,
    required this.isLoading,
    this.error,
  });

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (widget.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (widget.error != null) {
      return Scaffold(body: Center(child: Text('Erreur : ${widget.error}')));
    } else if (widget.forums.isEmpty) {
      return const Scaffold(body: Center(child: Text('Aucun forum trouvé')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des forums'),
        backgroundColor: const Color(0xFFebddcc),
        leading:
            authProvider.isLoggedIn
                ? Tools.icone(Icons.account_circle, "Mon compte", () async {
                  await SecureStorage().logout();
                  authProvider.logout();
                  versForums(context);
                })
                : Tools.icone(Icons.person_add_alt, "S'inscrire",
                  () => versRegister(context),
                ),
        actions: [
          if (authProvider.isLoggedIn && authProvider.isAdmin)
            Tools.icone(Icons.add_circle_outline, "Ajouter un forum",
              () => versAddEditForum(context, null),
            ),
          if (authProvider.isLoggedIn)
            Tools.icone(Icons.account_box, "Voir mon compte",
                  () => versUserDetail(context),
            ),
          if (!authProvider.isLoggedIn)
            Tools.icone(Icons.login, "Se connecter", () => versLogin(context)),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.forums.length,
        itemBuilder: (context, index) {
          Forum forum = widget.forums[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E4E4),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Tools.text(forum.nom, TextAlign.center, 18),
                          onTap: () {
                            //Redirection vers messagesForum
                          },
                        ),
                      ),
                      if (authProvider.isLoggedIn && authProvider.isAdmin) ...[
                        Tools.icone(Icons.settings, "Modifier le forum",
                          () => versAddEditForum(context, forum),
                        ),
                        Tools.icone(
                          Icons.delete_forever, "Supprimer le forum",
                          () => Tools.deleteAlerte(context, "Supprimer le forum",
                            "Voulez-vous supprimer le forum ${forum.nom} ? Tous ses messages seront supprimés.",
                            () => ForumApi().deleteForum(id: forum.id), () => versForums(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
