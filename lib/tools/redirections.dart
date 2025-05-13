import 'package:flutter/material.dart';
import '../controllers/registerController.dart';
import '../controllers/loginController.dart';
import '../controllers/addEditForumController.dart';
import '../controllers/mainController.dart';
import '../controllers/userDetailController.dart';
import '../controllers/forumController.dart';
import '../controllers/messageController.dart';
import '../controllers/addMessageController.dart';
import '../models/messageModel.dart';
import '../models/userModel.dart';
import 'authProvider.dart';
import 'secureStorage.dart';
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

versForum(BuildContext context, int forumId) async {
  List<Message> messages = await MessageApi().messagesSources(forumId);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ForumController(
        messages : messages,
        forumId : forumId
      )
    )
  );

}

versMessage(BuildContext context, int messageId) async {
  List<Message> messages = await MessageApi().messageReponses(messageId);
  Message messageSource = await MessageApi().oneMessage(messageId);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MessageController(
        messages : messages,
        messageSource: messageSource
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

versUserDetail(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const UserDetailController()),
  );
}

versAddMessage(BuildContext context, int forumId, {int? parentId}) async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  if (authProvider.isLoggedIn) {
    String? userMail = await SecureStorage().readEmail();
    int userId = 0; // id that can't work 
    if (userMail != null) {
      User? currentUser = await UserApi().getUserByEmail(userMail);
      if (currentUser != null) {
        userId = currentUser.id;
      }
    }

    bool showUserIdInput = authProvider.isAdmin;
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddMessageController(
          forumId: forumId,
          parentId: parentId,
          userId: userId,
          showUserIdInput: showUserIdInput
        )
      )
    );
  }
}