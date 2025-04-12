import 'package:flutter/material.dart';
import 'tools/redirections.dart';
import 'tools/tools.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Forum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFebddcc),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Tools.text("Bienvenue sur Forum !", TextAlign.center, 30),
            const SizedBox(height: 10),
            Tools.text(
              "Connectez-vous pour accéder à l'application",
              TextAlign.center,
              25,
            ),
            const SizedBox(height: 30),

            Tools.button(
              Tools.text("Aller aux forums", TextAlign.center, 18),
              () async {
                await versForums(context);
              }, Color(0xFFE4E4E4), Size.fromHeight(40),
            ),
            Tools.button(
              Tools.text("S'inscrire", TextAlign.center, 18),
                  () async {
                await versForums(context);
              }, Color(0xFFE4E4E4), Size.fromHeight(40),
            ),
            Tools.button(
              Tools.text("Se connecter", TextAlign.center, 18),
                  () async {
                await versForums(context);
              }, Color(0xFFE4E4E4), Size.fromHeight(40),
            ),
          ],
        ),
      ),
    );
  }
}
