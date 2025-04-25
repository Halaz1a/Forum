import 'package:flutter/material.dart';
import '../controllers/registerController.dart';
import '../controllers/loginController.dart';
import '../controllers/addEditForumController.dart';
import '../controllers/mainController.dart';
import '../controllers/forumController.dart';
import 'authProvider.dart';
import 'package:provider/provider.dart';
import '../models/forumModel.dart';
import '../models/messageModel.dart';

versForums(BuildContext context) {

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => HomeController(
      ),
    ),
    (Route<dynamic> route) => false,
  );
}

versForum(BuildContext context, int forumId) async {
  List<Message> messages = await MessageApi().messagesSources(forumId);
  
  Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context) => ForumController(
        messages : messages
      )
    )
  );

}

versRegister(BuildContext context) async {

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RegisterController(
      ),
    ),
  );
}

versLogin(BuildContext context) async {

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LoginController(
      ),
    ),
  );
}

versAddEditForum(BuildContext context, Forum? forumToEdit) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  if (authProvider.isAdmin){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditForumController(
          forumToEdit: forumToEdit
        ),
      ),
    );
  }
}