import 'package:flutter/material.dart';
import '../tools/redirections.dart';
import '../tools/tools.dart';
import '../tools/authProvider.dart';
import 'package:provider/provider.dart';
import '../models/forumModel.dart';
import '../controllers/forumController.dart';
import '../models/messageModel.dart';
import '../tools/secureStorage.dart';

class ForumView extends StatefulWidget {
  final List<Message> messages;
  final int forumId;
  final String? error;

  const ForumView({
    super.key,
    required this.messages,
    required this.forumId,
    this.error,
  });

  @override
  ForumViewState createState() => ForumViewState();
}

class ForumViewState extends State<ForumView> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (widget.error != null) {
      return Scaffold(body: Center(child: Text('Erreur : ${widget.error}')));
    } else if (widget.messages.isEmpty) {
      return const Scaffold(body: Center(child: Text('Aucun message trouvé')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions'),
        backgroundColor: const Color(0xFFebddcc),
        leading:
            authProvider.isLoggedIn
                ? Tools.icone(Icons.account_circle, "Mon compte",
                  () => versUserDetail(context),
                )
                : Tools.icone(Icons.person_add_alt, "S'inscrire",
                  () => versRegister(context),
                ),
        actions: [
          if (authProvider.isLoggedIn)
            Tools.icone(Icons.add_circle_outline, "Ajouter un message",
              () => versAddMessage(context, widget.forumId),
            ),
          if (!authProvider.isLoggedIn)
            Tools.icone(Icons.login, "Se connecter", () => versLogin(context)),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          Message message = widget.messages[index];
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
                          title: Tools.text(message.titre, TextAlign.center, 18),
                          subtitle: Tools.text(message.datePoste.toString(), TextAlign.center, 10),
                          onTap: () {
                            versMessage(context, message.id);
                          },
                        ),
                      ),
                      if (authProvider.isLoggedIn && authProvider.isAdmin) ...[
                        Tools.icone(
                          Icons.delete_forever, "Supprimer le message",
                          () => Tools.deleteAlerte(context, "Supprimer le message",
                            "Voulez-vous supprimer le message ${message.titre} ? Toutes ses réponses seront supprimées.",
                            () => MessageApi().deleteMessage(id: message.id), () => versForum(context, message.forumId),
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
