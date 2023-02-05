import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 

import '../components/roundedButton.dart';
import 'loginScreen.dart';
import 'registratinScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'wecolmScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

AnimationController? aConrtoler;
Animation? animation;
// void dd(){
//   FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//          print('snapshoot erro ${snapshot.hasError}');
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//             print('snapshoot completed ${snapshot.hasError}');
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Text('ddddddddddddddddddddddd');
//       },
//     );
// }
void anothermethod()async{
  try{
 await  Firebase.initializeApp();
 print('cccccccccccccc compeleted');
  }catch(e){
    print('catched erro ....$e');
  }


 

}



class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  @override
  void initState() {
    super.initState();
   anothermethod();
    aConrtoler =new AnimationController(duration: Duration(seconds: 3), vsync: this);
    // animation = CurvedAnimation(parent: aConrtoler!, curve: Curves.decelerate);
    animation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(aConrtoler!);
    // animation!.addListener(() {
    //   if (animation!.status == AnimationStatus.completed) {
    //     aConrtoler!.reverse(from: 1);
    //   } else if (animation!.status == AnimationStatus.dismissed)
    //     aConrtoler!.forward();
    // });
    // if (anim)]]
    aConrtoler!.forward();
    aConrtoler!.addListener(() {
      print(animation!.status);
      print(aConrtoler!.value);
      setState(() {});
    });
  }

  @override
  void dispose() {
    aConrtoler!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/log2.webp'),
                    height: 60,
                  ),
                ),
                // Container(
                //   width: 250.0,
                //   child: DefaultTextStyle(
                //     style: const TextStyle(
                //       fontSize: 40.0,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w900,
                //     ),
                //     child: AnimatedTextKit(
                //       animatedTexts: [TypewriterAnimatedText('Flash Chat')],
                //       onTap: () {
                //         print("Tap Event");
                //       },
                //       // style: TextStyle(
                //       //   fontSize: 45.0,
                //       //   fontWeight: FontWeight.w900,
                //       // ),
                //     ),
                //   ),
                // )
SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    
                    child: AnimatedTextKit(
    animatedTexts: [
      TypewriterAnimatedText('CA197 ',textStyle: GoogleFonts.varelaRound(color: Colors.black,fontSize: 30,fontWeight:FontWeight.bold)),
      TypewriterAnimatedText('chat App',textStyle: GoogleFonts.varelaRound(color: Colors.black,fontSize: 45)),
    ],
    // isRepeatingAnimation: true,
     
  ),
                    
                    // TextLiquidFill(
                    //   text: 'Monster',
                    //   waveColor: Colors.red,
                    //   boxBackgroundColor: Colors.green,
                    //   textStyle: TextStyle(
                    //     fontSize: 40.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    //   boxHeight: 200.0,
                    // ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            roundedButton(
              text: 'Login',
              color: Colors.lightBlueAccent,
              onpressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (d) => RegistrationScreen()));
              },
            ),
            roundedButton(
              text: 'Register',
              color: Colors.blueAccent,
              onpressed: () {
                // Navigator.pushNamed(context, RegistrationScreen.id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (d) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}