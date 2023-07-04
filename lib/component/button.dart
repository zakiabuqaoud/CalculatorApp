
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color buttonBGColor;
  final Color buttonTextColor;
  final Function buttonTapped;

  const Button({Key? key, required this.buttonText, required this.buttonBGColor, required this.buttonTextColor, required this.buttonTapped }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        onTap: (){buttonTapped();},
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5.0),
          color: buttonBGColor,
          child: Text(buttonText, style: TextStyle(color: buttonTextColor, fontSize: 23),),
        ),
      ),
    );
  }
}
