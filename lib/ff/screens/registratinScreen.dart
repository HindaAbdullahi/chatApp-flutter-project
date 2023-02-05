import 'package:firebase/ff/screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:flutter_application_1/components/roundedButtton.dart';
 
// import 'package:firebase_auth/firebase_auth.dart';

import '../components/roundedButton.dart';
import '../components/roundedTextBox.dart';
import 'chatScreen.dart';

final auth = FirebaseAuth.instance;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegSceern';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
bool startspin2=false;
class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email  ;
  late String password ;
  //   late String emailcheckingLable   ;
  // late String passwordchekingLable ;
   final _formKey = GlobalKey<FormState>();
    final emailTexcontroler = TextEditingController();
    final passwordTexcontroler = TextEditingController();
    final userNameTexcontroler = TextEditingController();
      bool ggg=false;
  bool startspin=false;
  SpinKitFadingCircle loading(){
     return   SpinKitFadingCircle(
  color: Colors.black,
  size: 70.0);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create an Account ", style: GoogleFonts.poppins(),),),
      backgroundColor: Colors.white,
      body:  ModalProgressHUD(
 inAsyncCall:startspin2,
  
        child:ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child:    Container(
                    height: 200.0,
                    child: Image.asset('images/log2.webp'),
                  ),
                ),
               const    SizedBox(
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
                    text: 'Register',
                    color:  Color.fromARGB(255, 127, 255, 68),
                    onpressed: () async { 
                      if (_formKey.currentState!.validate()) {
                   startspin=true;
                   setState(() {
                     
                   });
                      try{
      var myuser = await auth.createUserWithEmailAndPassword(
                          email: emailTexcontroler.text.trim(), password: passwordTexcontroler.text.trim());
     
         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Successfully Registerd')),
                        );
         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Login Now')),
                        );
        Navigator.pushNamed(context, LoginScreen.id);

                      }catch(e){
                        print('eeeeeeeeerrro $e');
         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                        
                            backgroundColor: Colors.red,
                            content: Text('user Already registred')),
                        );
                      }
                      //ggg=false;
                      startspin=false;
                    setState(() {
                      
                    });
       
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
     ) );
  }
}

//       roundedButton(
//                   text: 'Register',
//                   color: Colors.blueAccent,
//                   onpressed: () async {
//                     startspin2=true;
//                     print('my email is $email and my password is $password');
 
//  try {
//                       var myuser = await auth.createUserWithEmailAndPassword(
//                           email: email.trim(), password: password.trim());
//                           print('ddddddddd created');
                
//                         Navigator.pushNamed(context, ChatScreen.id);
//                           startspin2=false;
//                     } catch (e) {
//                       print('the errro is drdbjjj $e');
//                     }
 
                   

//                //  auth.createUserWithEmailAndPassword(email: email, password: password);
//                     // Navigator.pushNamed(context, RegistrationScreen.id);
//                     // Navigator.push(context,
//                     //     //MaterialPageRoute(builder: (d) => RegistrationScreen()));
//                   },
//                 ),