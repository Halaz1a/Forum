import 'package:flutter/material.dart';
import '../main.dart';
import '../models/forumModel.dart';

class HomeController extends StatefulWidget {

  const HomeController({super.key});

  @override
  HomeControllerState createState() => HomeControllerState();
}

class HomeControllerState extends State<HomeController> {
  List<Forum> forums = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    allForums();
  }

  @override
  Widget build(BuildContext context) {
    return Home(
      forums: forums,
      isLoading: isLoading,
      error: error,
    );
  }

  Future<void> allForums() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      List<Forum> listeForums = await ForumApi().allForums();
      setState(() {
        forums = listeForums;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      print(e);
    }
  }
}