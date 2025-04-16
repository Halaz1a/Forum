import 'package:flutter/material.dart';
import '../tools/tools.dart';

class LoginView extends StatefulWidget {
  final Key? keyForm;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginView({super.key, required this.keyForm, required this.emailController,
    required this.passwordController, required this.onPressed, required this.isLoading});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connexion'),
          backgroundColor: Color(0xFFebddcc),
        ),
        body: Form(
          key: widget.keyForm,
          child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Tools.text("Email : ", TextAlign.start, 18),
                  Tools.textForm(widget.emailController, TextInputType.text,
                    "Email", false,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un email';
                      } else if (!RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Tools.text("Mot de passe : ", TextAlign.start, 18),
                  Tools.textForm(widget.passwordController, TextInputType.text,
                    "Mot de passe", true,
                        (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : Tools.button(Tools.text("Se connecter", TextAlign.center, 16),
                    widget.onPressed, Color(0xFFE4E4E4), Size.fromHeight(40)
                  ),
                ],
              )
          ),
        )
    );
  }
}