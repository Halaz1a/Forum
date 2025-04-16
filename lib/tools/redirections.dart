import 'package:flutter/material.dart';
import '../controllers/registerController.dart';
import '../controllers/loginController.dart';
import '../main.dart';

versForums(BuildContext context) {

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Home()),
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