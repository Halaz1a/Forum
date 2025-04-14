import 'package:flutter/material.dart';
import 'package:forum/tools/redirections.dart';
import '../models/userModel.dart';
import '../views/registerView.dart';
import '../tools/verifications.dart';

class RegisterController extends StatefulWidget {

  const RegisterController({super.key});

  @override
  RegisterControllerState createState() => RegisterControllerState();
}

class RegisterControllerState extends State<RegisterController>{
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return RegisterView(
      keyForm: _formKey,
      emailController: _emailController,
      nomController: _nomController,
      prenomController: _prenomController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      onPressed: () async {
        _register();
      }
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      if(_emailController.text.isNotEmpty && _nomController.text.isNotEmpty &&
      _prenomController.text.isNotEmpty && _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty) {

        try {
          String passwordHash = Verifications().hashPassword(_passwordController.text);

          var reponse = await UserApi().registerUser(email: _emailController.text,
              nom: _nomController.text.toUpperCase(), prenom: _prenomController.text,
              password: passwordHash);

          if (reponse == 201){
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Inscription réussie'),
                content: Text(
                    'Bonjour, ${_prenomController.text} ${_nomController.text} !'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                    },
                  ),
                ],
              ),
            );

            versForums(context);
          }

        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Erreur'),
              content: Text('Erreur lors de l\'inscription: $e'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }

      }
    }
  }
}