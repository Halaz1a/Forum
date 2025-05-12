import 'package:flutter/material.dart';
import '../views/UserDetailView.dart';
import '../tools/secureStorage.dart';

class UserDetailController extends StatefulWidget {
  const UserDetailController({super.key});

  @override
  UserDetailControllerState createState() => UserDetailControllerState();
}

class UserDetailControllerState extends State<UserDetailController> {
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final email = await SecureStorage().readEmail();
    setState(() {
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_email == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return UserDetailView(email: _email!);
  }
}
