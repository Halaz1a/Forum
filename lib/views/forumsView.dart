import '../models/forumModel.dart';
import 'package:flutter/material.dart';
import '../tools/tools.dart';

class ForumsView extends StatefulWidget {
  final List<Forum> forums;

  const ForumsView({super.key, required this.forums});

  @override
  ForumsViewState createState() => ForumsViewState();
}

class ForumsViewState extends State<ForumsView> {
  late Future<List<Forum>> futureForums;

  @override
  void initState() {
    super.initState();
    futureForums = ForumApi().allForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des forums'),
        backgroundColor: Color(0xFFebddcc),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Forum>>(
        future: futureForums,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun forum trouvé.'));
          } else {
            List<Forum> forums = snapshot.data!;

            return ListView.builder(
              itemCount: forums.length,
              itemBuilder: (context, index) {
                Forum forum = forums[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Color(0xFFE4E4E4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        title: Tools.text(forum.nom.toUpperCase(), TextAlign.center, 18),
                        onTap: () {
                          //
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
