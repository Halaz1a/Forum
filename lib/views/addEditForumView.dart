import 'package:flutter/material.dart';
import '../tools/tools.dart';
import '../models/forumModel.dart';

class AddEditForumView extends StatefulWidget {
  final Key? keyForm;
  final TextEditingController nomController;
  final Forum? forumToEdit;
  final VoidCallback onPressed;

  const AddEditForumView({super.key, required this.keyForm, required this.nomController,
    required this.forumToEdit, required this.onPressed});

  @override
  AddEditForumViewState createState() => AddEditForumViewState();
}

class AddEditForumViewState extends State<AddEditForumView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajouter un forum'),
          backgroundColor: Color(0xFFebddcc),
        ),
        body: Form(
          key: widget.keyForm,
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Tools.text("Nom du forum : ", TextAlign.start, 18),
                  Tools.textForm(widget.nomController, TextInputType.text,
                    "Nom du forum", false,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  Tools.button(Tools.text((widget.forumToEdit == null) ? "Ajouter le forum" : "Modifier le forum",
                      TextAlign.center, 16), widget.onPressed, Color(0xFFE4E4E4), Size.fromHeight(40)
                  ),
                ],
              )
          ),
        )
    );
  }
}