import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/forumModel.dart';
import '../controllers/forumsController.dart';
import '../controllers/registerController.dart';

versForums(BuildContext context) async {
  List<Forum> forums = await ForumApi().allForums();

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ForumsController(
          forums: forums,
        ),
    ),
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