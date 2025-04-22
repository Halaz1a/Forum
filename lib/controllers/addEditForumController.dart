import 'package:flutter/material.dart';
import '../models/forumModel.dart';
import '../views/addEditForumView.dart';
import '../tools/redirections.dart';
import '../tools/tools.dart';

class AddEditForumController extends StatefulWidget {
  final Forum? forumToEdit;

  const AddEditForumController({super.key, this.forumToEdit});

  @override
  AddEditForumControllerState createState() => AddEditForumControllerState();
}

class AddEditForumControllerState extends State<AddEditForumController> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;

  @override
  void initState(){
    super.initState();
    _nomController = TextEditingController(
        text: widget.forumToEdit != null ? widget.forumToEdit!.nom : '');
  }

  @override
  void dispose(){
    _nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddEditForumView(
        keyForm: _formKey,
        forumToEdit: widget.forumToEdit,
        nomController: _nomController,
        onPressed: () async {
          widget.forumToEdit != null ? _editForum() : _addForum();
        }
    );
  }

  Future<void> _addForum() async {
    if (_formKey.currentState?.validate() ?? false){
      if(_nomController.text.isNotEmpty) {
        try {
          await ForumApi().addForum(nom: _nomController.text);
          versForums(context);

        } catch (e) {
          Tools.alerte(
              context, "Erreur", "Erreur lors de l'ajout : $e");
        }
      } else {
        Tools.alerte(
            context, "Erreur", "Vous n'avez pas rempli tous les champs");
      }
    }
  }

  Future<void> _editForum() async {
    if (_formKey.currentState?.validate() ?? false){
      if(_nomController.text.isNotEmpty) {
        try {
          await ForumApi().editForum(id: widget.forumToEdit!.id, nom: _nomController.text);
          versForums(context);

        } catch (e) {
          Tools.alerte(
              context, "Erreur", "Erreur lors de l'ajout : $e");
        }
      } else {
        Tools.alerte(
            context, "Erreur", "Vous n'avez pas rempli tous les champs");
      }
    }
  }
}