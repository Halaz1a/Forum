import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../tools/redirections.dart';
import '../tools/secureStorage.dart';
import '../tools/tools.dart';
import '../models/userModel.dart';
import '../views/loginView.dart';
import '../tools/authProvider.dart';

class LoginController extends StatefulWidget {

  const LoginController({super.key});

  @override
  LoginControllerState createState() => LoginControllerState();
}

class LoginControllerState extends State<LoginController> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final SecureStorage secureStorage = SecureStorage();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loadCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginView(
        keyForm: _formKey,
        isLoading: _isLoading,
        emailController: _emailController,
        passwordController: _passwordController,
        onPressed: () async {
          _login();
        }
    );
  }

  Future<void> _loadCredentials() async {
    final credentials = await secureStorage.readCredentials();
    setState(() {
      _emailController.text = credentials['email'] ?? '';
      _passwordController.text = credentials['password'] ?? '';
    });
    await secureStorage.saveEmail(_emailController.text);
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await UserApi().login(
            _emailController.text, _passwordController.text);
        final responseData = json.decode(response.body);

        await secureStorage.saveCredentials(
            _emailController.text, _passwordController.text);
        Provider.of<AuthProvider>(context, listen: false).login();
        await secureStorage.saveToken(responseData['token']);
        await secureStorage.saveRoles(responseData['data']['roles']);
        Provider.of<AuthProvider>(context, listen: false).admin();

        Tools.info(context, "Authentification réussie");

        Future.delayed(Duration(seconds: 2), () {
          versForums(context);
        });
      } catch (e) {
        Tools.alerte(
            context, "Erreur", "Erreur lors de l'authentification : $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}