import 'package:flutter/material.dart';
 

class roundedButton extends StatelessWidget {
  final String? text;
  final Color color;
  final void Function()? onpressed;

  roundedButton(
      {required this.text, required this.color, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text!,
          ),
        ),
      ),
    );
  }
}