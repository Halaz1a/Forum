import 'package:flutter/material.dart';
import 'package:forum/controllers/addMessageController.dart';
import '../tools/tools.dart';
import '../models/forumModel.dart';

class AddMessageView extends StatefulWidget {
  final Key? keyForm;
  final TextEditingController titreInput;
  final TextEditingController contenuInput;
  final TextEditingController userIdInput;
  final int forumId;
  final int? parentId;
  final VoidCallback onPressed;

  const AddMessageView({super.key, required this.keyForm, required this.titreInput,
    required this.contenuInput, required this.userIdInput, required this.forumId, this.parentId, required this.onPressed});

  @override
  AddMessageViewState createState() => AddMessageViewState();
}

class AddMessageViewState extends State<AddMessageView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajouter un message'),
          backgroundColor: Color(0xFFebddcc),
        ),
        body: Form(
          key: widget.keyForm,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Tools.text("Titre du message : ", TextAlign.start, 18),
                  Tools.textForm(widget.titreInput, TextInputType.text,
                    "Titre du message", false,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre';
                      }
                      return null;
                    },
                  ),
                  Tools.text("Contenu du message : ", TextAlign.start, 18),
                  Tools.textForm(widget.contenuInput, TextInputType.text,
                    "Contenu du message", false,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un contenu';
                      }
                      return null;
                    },
                  ),
                  Tools.text("Id de l'auteur : ", TextAlign.start, 18),
                  Tools.textForm(widget.userIdInput, TextInputType.text,
                    "Id de l'auteur", false,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un id';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Tools.button(Tools.text("publier le message",
                      TextAlign.center, 16), widget.onPressed, Color(0xFFE4E4E4), Size.fromHeight(40)
                  ),
                ],
              )
          ),
        )
    );
  }
}