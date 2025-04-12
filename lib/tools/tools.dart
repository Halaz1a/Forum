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

  static Widget button(Widget child, Future<void> Function() onPressed,
      Color backgrounColor, Size fixedSize){
    return ElevatedButton(
      onPressed: () async {
        try {
          await onPressed();
        } catch (error) {
          print("Erreur dans l'exécution de la fonction : $error");
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgrounColor,
        fixedSize: fixedSize,
      ),
      child: child,
    );
  }
}

