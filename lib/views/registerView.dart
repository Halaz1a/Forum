import 'package:flutter/material.dart';
import '../tools/tools.dart';

class RegisterView extends StatefulWidget {
  final Key? keyForm;
  final TextEditingController emailController;
  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onPressed;

  const RegisterView({super.key, required this.keyForm,
  required this.emailController, required this.nomController,
  required this.prenomController, required this.passwordController,
  required this.confirmPasswordController, required this.onPressed});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        backgroundColor: Color(0xFFebddcc),
      ),
      body: Form(
        key: widget.keyForm,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Tools.text("Nom : ", TextAlign.start, 18),
              Tools.textForm(widget.nomController, TextInputType.text,
                  "Nom", false,
                    (value){
                  if (value == null || value.isEmpty){
                    return 'Veuillez entrer votre nom';
                  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Veuillez n\'utiliser que des lettres';
                  } return null;
                },
              ),
              SizedBox(height: 20),
              Tools.text("Prénom : ", TextAlign.start, 18),
              Tools.textForm(widget.prenomController, TextInputType.text,
                "Prénom", false,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Veuillez n\'utiliser que des lettres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
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
                  if (value.length < 12) {
                    return 'Le mot de passe doit contenir au moins 12 caractères';
                  }
                  if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                    return 'Le mot de passe doit contenir au moins une minuscule';
                  }
                  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                    return 'Le mot de passe doit contenir au moins une majuscule';
                  }
                  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                    return 'Le mot de passe doit contenir au moins un chiffre';
                  }
                  if (!RegExp(r'(?=.*[\W])').hasMatch(value)) {
                    // \W signifie tout caractère qui n'est pas une lettre ou un chiffre
                    return 'Le mot de passe doit contenir au moins un caractère spécial';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Tools.text("Confirmation du mot de passe : ", TextAlign.start, 18),
              Tools.textForm(widget.confirmPasswordController, TextInputType.text,
                "Confirmation du mot de passe", true,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez confirmer votre mot de passe';
                  } else if (value != widget.passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                title: Text('Accepter les termes et conditions'),
                value: agreeToTerms,
                onChanged: (bool? newValue) {
                  setState(() {
                    agreeToTerms = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 20),
              Tools.button(
                Tools.text("S'inscrire", TextAlign.center, 16),
                  agreeToTerms ? widget.onPressed : null, Color(0xFFE4E4E4), Size.fromHeight(40),
              ),
            ],
          )
        ),
      )
    );
  }
}