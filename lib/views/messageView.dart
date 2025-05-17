import 'package:flutter/material.dart';
import '../tools/redirections.dart';
import '../tools/tools.dart';
import '../tools/authProvider.dart';
import 'package:provider/provider.dart';
import '../models/messageModel.dart';
import '../tools/secureStorage.dart';

class MessageView extends StatefulWidget {
  final List<Message> messages;
  final Message messageSource;
  final String? error;

  const MessageView({
    super.key,
    required this.messages,
    required this.messageSource,
    this.error,
  });

  @override
  MessageViewState createState() => MessageViewState();
}

class MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (widget.error != null) {
      return Scaffold(body: Center(child: Text('Erreur : ${widget.error}')));
    } 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
        backgroundColor: const Color(0xFFebddcc),
        leading: authProvider.isLoggedIn
            ? Tools.icone(Icons.account_circle, "Mon compte",
              () => versUserDetail(context),
            )
            : Tools.icone(Icons.person_add_alt, "S'inscrire",
              () => versRegister(context),
            ),
        actions: [
          if (!authProvider.isLoggedIn)
            Tools.icone(Icons.login, "Se connecter", () => versLogin(context)),
        ],
      ),
      
      body: CustomScrollView(
        slivers: [
          // message source 
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.messageSource.titre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.messageSource.datePoste.toString(),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.messageSource.contenu ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Réponses',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // réponses
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                Message message = widget.messages[index];
                return ListTile(
                  title: Text(
                    message.titre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    message.datePoste.toString(),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  onTap: () {
                    versMessage(context, message.id);
                  },
                  trailing: authProvider.isLoggedIn && authProvider.isAdmin
                      ? IconButton(
                          icon: const Icon(Icons.delete_forever),
                          onPressed: () => Tools.deleteAlerte(
                            context, 
                            "Supprimer le message",
                            "Voulez-vous supprimer le message ${message.titre} ? Toutes ses réponses seront supprimées.",
                            () => MessageApi().deleteMessage(id: message.id), 
                            () => versForum(context, message.forumId),
                          ),
                        )
                      : null,
                );
              },
              childCount: widget.messages.length,
            ),
          ),
        ],
      ),
      
      // réponse au message 
      floatingActionButton: authProvider.isLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                versAddMessage(context, widget.messageSource.forumId, parentId: widget.messageSource.id);
              },
              child: const Icon(Icons.reply),
            )
          : null,
    );
  }
}