import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
 
 
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/roundedButton.dart';
import '../components/roundedTextBox.dart';
import 'chatScreen.dart';
final loginuser=FirebaseAuth.instance;
late String email;
late String password;

SpinKitFadingCircle loading(){
     return   SpinKitFadingCircle(
  color: Colors.black,
  size: 70.0);
}
class LoginScreen extends StatefulWidget {
  static const String id = 'loginScren';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
  bool ggg=false;
  bool startspin=false;
    final _formKey = GlobalKey<FormState>();
    final emailTexcontroler = TextEditingController();
    final passwordTexcontroler = TextEditingController();
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text("Login", style: GoogleFonts.poppins(),),),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
 inAsyncCall:startspin,
  
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/log2.webp'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                   Form(
  key: _formKey,
  child: Column(children:[

                  RoundedTextBox(
                    textEditingController: emailTexcontroler,
                    hintText: 'Enter your Email',
                    onChanged: (value) {
                      email=value;
                      //Do something with the user input.
                    },
                  ),
                  SizedBox(
                   // color: Colors.amber,
                  height: 8,
                   
                    ///ggg==true?loading():null,
                  ),
                  RoundedTextBox(
                    textEditingController: passwordTexcontroler,
                    starPassword_Hide: true,
                    hintText: 'Enter your password',
                    onChanged: (value) {
                      password=value;
                      //Do something with the user input.
                    },
                  
                  ),
                  SizedBox(
                    height: 40.0,
                    child:  ggg==true?loading():null
      ),
                
                      roundedButton(
                    text: 'Login',
                    color: Colors.lightBlueAccent,
                    onpressed: () async { 
                      if (_formKey.currentState!.validate()) {
                   startspin=true;
                   setState(() {
                     
                   });
                      try{
        await loginuser.signInWithEmailAndPassword(email: emailTexcontroler.text,password: passwordTexcontroler.text);
        print('loged in fffffffff');
         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Loged successfully')),
                        );
        Navigator.pushNamed(context, ChatScreen.id);

                      }catch(e){
                        print('eeeeeeeeerrro $e');
         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                        
                            backgroundColor: Colors.red,
                            content: Text('Invalid email or password')),
                        );
                      }
                      //ggg=false;
                      startspin=false;
                    setState(() {
                      
                    });
        log("ereeeeeeeeeeeeee");
                      log(emailTexcontroler.text);
                      log(passwordTexcontroler.text);
                       emailTexcontroler.clear();
                       passwordTexcontroler.clear();
                      }
                   //ggg=true;
                      // Navigator.pushNamed(context, LoginScreen.id);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (d) => RegistrationScreen()));
                    },
                  ),
    
  ]),

                   ),
                  
           
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}