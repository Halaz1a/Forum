import 'package:flutter/material.dart';
import '../models/userModel.dart';

class UserDetailView extends StatefulWidget {
  final String email;

  const UserDetailView({Key? key, required this.email}) : super(key: key);

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      print("Fetching user with email: ${widget.email}");
      User? fetchedUser = await UserApi().getUserByEmail(widget.email);
      if (fetchedUser != null) {
        print("User fetched successfully: ${fetchedUser.nom}");
      } else {
        print("User not found for email: ${widget.email}");
      }
      setState(() {
        _user = fetchedUser;
        _isLoading = false;
      });
    } catch (e) {
      print("Erreur lors de la récupération de l'utilisateur : $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Détail de l'utilisateur")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _user == null
          ? Center(child: Text("Utilisateur non trouvé"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text("Nom : ${_user!.nom}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Prénom : ${_user!.prenom}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Email : ${_user!.email}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Rôles : ${_user!.roles.join(', ')}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text("Date d'inscription : ${_user!.dateInscription.toLocal()}",
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
