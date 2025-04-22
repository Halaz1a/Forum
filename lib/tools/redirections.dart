import 'package:flutter/material.dart';
import '../controllers/registerController.dart';
import '../controllers/loginController.dart';
import '../controllers/addEditForumController.dart';
import '../controllers/mainController.dart';
import '../main.dart';
import 'authProvider.dart';
import 'package:provider/provider.dart';
import '../models/forumModel.dart';

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