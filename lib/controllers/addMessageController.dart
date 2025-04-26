import 'package:flutter/material.dart';
import '../models/messageModel.dart';
import '../views/addMessageView.dart';
import '../tools/redirections.dart';
import '../tools/tools.dart';

class AddMessageController extends StatefulWidget {
  final int forumId;
  final int? parentId;

  const AddMessageController({super.key, required this.forumId, this.parentId});

  @override
  AddEditForumControllerState createState() => AddEditForumControllerState();
}

class AddEditForumControllerState extends State<AddMessageController> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titreInput;
  late TextEditingController _contenuInput;
  late TextEditingController _userIdInput;


  @override
  void initState(){
    super.initState();
    _titreInput = TextEditingController(
      text: '');
    _contenuInput = TextEditingController(
      text: '');
    _userIdInput = TextEditingController(
      text: '');
  }

  @override
  void dispose(){
    _titreInput.dispose();
    _contenuInput.dispose();
    _userIdInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddMessageView(
        keyForm: _formKey,
        forumId: widget.forumId,
        parentId: widget.parentId,
        titreInput: _titreInput,
        contenuInput: _contenuInput,
        userIdInput: _userIdInput,
        onPressed: () async {
          _addMessage();
        }
    );
  }

  Future<void> _addMessage() async {
    if (_formKey.currentState?.validate() ?? false){
      if(_titreInput.text.isNotEmpty && _contenuInput.text.isNotEmpty & _userIdInput.text.isNotEmpty) {
        try {
          await MessageApi().addMessage(titre: _titreInput.text, contenu: _contenuInput.text, userId: int.parse(_userIdInput.text), forumId: widget.forumId, parentId: widget.parentId);
          versForum(context, widget.forumId);

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