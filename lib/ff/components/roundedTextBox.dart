import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  final String hintText;
  bool starPassword_Hide;
  TextEditingController textEditingController;
  void Function(String)? onChanged;
  RoundedTextBox(
      {this.starPassword_Hide = false,
      required this.hintText,
      required this.onChanged,required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      controller: textEditingController,
      validator: (value) {
                    if (value == null || value.isEmpty ) {
                      return 'Please enter some text';}
                    
                   if(starPassword_Hide) {

                   if(value.length<6)
                      return 'password must be grater than 6';
                   }
                      else{

                   if(!value.contains('@gmail.com'))
                      return 'enter valid email';
                      }
                      
                
                    
                    return null;
                  },
      keyboardType: TextInputType
          .emailAddress, //------------>email sing ka ooo kuso dhaweena
      obscureText: starPassword_Hide,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.green,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}