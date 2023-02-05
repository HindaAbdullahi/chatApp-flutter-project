import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final MesssageTexcontroler = TextEditingController();
final fStore = FirebaseFirestore.instance;
final auth2 = FirebaseAuth.instance;
late String userEmail;


void getUserEmail() async {

//TODO getting current login userNAme
  final myuser = await auth2.currentUser!.email;
  //
  print('my eemail..........${myuser!}');
  userEmail = myuser;
}

//TODO Reading the Data
reddatafromfstore() async {
  try {
    print('wwwwwwwwwwwwwwwooo entered');
    final ff = await fStore.collection('messages').snapshots();

    ff.map((e) => e.docs.map((e) => print(e.data())).toString()).toList();

    //   final ss=ff;
    // await ss.map((e) =>{
    //  e.docs.map((e) => print(e.data())).toList()
    // }).toList();
    // for (var item in ss) {
    //   print(item.data());
    // }

    //  print(ff.le);

    print('wwwwwwwwwwwwwwwooo end');
  } catch (e) {
    print('gtttttttttttttttt $e');
  }
  //  print('wwwwwwwwwwwwwwwooo entered');
  //  final ff=await fStore.collection('messages').get();
  //   final ss=ff.docs;
  //  ss.map((e) => print(e.data())).toList();
  //   for (var item in ss) {
  //     print(item.data());
}

late String usertext;

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    
    super.initState();

    getUserEmail();
    //print('my emeial is.........inits......  orr  is $userEmail}');
  }

  // Future<void> rr() async {
  //   var d = await fStore.collection('messages').snapshots();
  //   await d
  //       .map((e) => e.docs.map((e) => print(e.data()['text'])).toList())
  //       .toList();
  // }

  // List messages = [];
  // getMessage(List data) {
  //   messages = data;
   
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                
                //Implement logout functionality
                //   await reddatafromfstore();
                auth2.signOut();
                Navigator.pop(context);
              }),
        ],
        title:  Text('CA197 Chat Room ', style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Expanded(
          child: Container(
             decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.cover,
          )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: fStore.collection('messages') .orderBy('date', descending: false).snapshots(),
                    builder: (context, snapshoot) {
                      List<Messsag> dd = [];
                      late String massagetext;
                      String sender;
                      // String sendTime;
                      if (!snapshoot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshoot.hasData) {
                        snapshoot.data!.docs.reversed.map(((e) {
                          massagetext = e['text'];
                          sender = e['sender'];
                          // sendTime = e['date'];
                          if (sender == userEmail) {
                            dd.add(Messsag(
                              sender: sender,
                              text: massagetext,
                              date: e['date'].toDate()
                            ));
                        
                            print(dd);
                          } else {
                            dd.add(Messsag(
                              sender: sender,
                              text: massagetext,
                              isme: false,
                              date: e['date'].toDate()
                            ));
                          }
                          // dd.sort((a, b) => a.date.compareTo(b.date));
                        })).toList();
                      }
                      return Expanded(

                        //here
                          child: ListView( 
                              reverse: true,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              children: dd));
                    }),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
            color: Colors.lightBlueAccent,
            
                          child: TextField(
                          
                            controller: MesssageTexcontroler,
                            onChanged: (value) {
                              //Do something with the user input.
                              usertext = value;
                            },
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                      ),

                      //send the messsage
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          try {
                            fStore.collection('messages').add({
                              'sender': await userEmail,
                              'text': MesssageTexcontroler.text,
                              'date': DateTime.now()
                            });
                            MesssageTexcontroler.clear();
                          } catch (e) {
                            print('dddd Exception is... $e');
                          }
                          //Implement send functionality.
                        },
                        // child: const Text(
                        //   'Send',
                        //   style: kSendButtonTextStyle,
                        // ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var boder1 = const BorderRadius.only(
    topLeft: const Radius.circular(20),
    bottomLeft: const Radius.circular(20),
    // bottomRight: const Radius.circular(20),
    topRight: const Radius.circular(20));
    
var boder2 = const BorderRadius.only(
    // bottomLeft: Radius.circular(30),
    topLeft: Radius.circular(20),
    bottomRight: const Radius.circular(20),
    topRight: Radius.circular(20));
  

//





class Messsag extends StatelessWidget {
  final String sender;
  final String text;
  final DateTime date;
  bool isme;
  // ignore: use_key_in_widget_constructors
  Messsag(
      {required this.text,
      required this.sender,
      this.isme = true,
      required this.date});
  @override
  Widget build(BuildContext context) {
    var crossAxisAlignment1 = CrossAxisAlignment.end;
    var crossAxisAlignment2 = CrossAxisAlignment.start;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: isme ? crossAxisAlignment1 : crossAxisAlignment2,
          children: [
            Text(
              sender.substring(0, sender.indexOf('@')),
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
           
            
            Material(
                elevation: 5,
                borderRadius: isme ? boder1 : boder2,
                color: isme ? Colors.lightBlue : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text(
                    text,
                    style: TextStyle(color: isme ? Colors.white : Colors.black),
                  ),
                ))
                ,
                Text( '${date.hour}:${date.minute} PM',style: TextStyle(fontSize: 10),)
          ]),
    );
  }
}
