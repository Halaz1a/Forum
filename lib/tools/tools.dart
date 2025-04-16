import 'package:flutter/material.dart';

class Tools{

  static Widget text(String text, TextAlign textAlign, double fontSize){
    return Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
        )
    );
  }

  static Widget textForm(TextEditingController controller, TextInputType type,
      String hintText, bool obscureText, validator){
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }

  static Widget button(Widget child, Function()? onPressed,
      Color backgrounColor, Size fixedSize){
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (onPressed != null) {
            try {
              final result = onPressed();
              // Vérifie si le résultat est un Future (asynchrone)
              if (result != null && result is Future) {
                await result;
              }
            } catch (error) {
              print("Erreur dans l'exécution de la fonction : $error");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgrounColor,
          fixedSize: fixedSize,
        ),
        child: child,
      )
    );
  }

  static ScaffoldFeatureController info(BuildContext context, String text){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Tools.text(text, TextAlign.left, 18)),
    );
  }

  static Future<void> alerte(BuildContext context, String titre, String content){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titre),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static Widget icone(IconData icon, String tooltip, Future<void> Function() onPressed){
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}

