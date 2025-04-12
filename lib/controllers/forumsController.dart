import 'package:flutter/cupertino.dart';
import 'package:forum/models/forumModel.dart';
import '../views/forumsView.dart';

class ForumsController extends StatefulWidget {
  final List<Forum> forums;

  const ForumsController({super.key, required this.forums});

  @override
  ForumsControllerState createState() => ForumsControllerState();
}

class ForumsControllerState extends State<ForumsController>{
  @override
  Widget build(BuildContext context){
    return ForumsView(
      forums: widget.forums,
    );
  }
}
