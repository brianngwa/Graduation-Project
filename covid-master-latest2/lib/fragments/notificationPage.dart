import 'package:covid/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:covid/navigationDrawer/navigationDrawer.dart';
import 'package:covid/helpers/style.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/helpers/user.dart';
import 'package:covid/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covid/widgets/custom_button.dart';


class notificationPage extends StatelessWidget {
 static const String routeName = '/notificationPage';

 @override
 Widget build(BuildContext context) {
   return new Scaffold(
       appBar: AppBar(
         title: CustomText(text: "Notifications ", color: white, size: 20),
          centerTitle: true,
          elevation: 0.5,
       ),
       drawer: navigationDrawer(),
       body: MessageHandler(),
       
       
       );
 }
}
class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  List<Message> _messages;
  StreamSubscription iosSubscription;



    getToken()  async{
     FirebaseUser _user = await _auth.currentUser();
    _fcm.getToken().then((deviceToken) async {
      print('device token: $deviceToken');
       if (deviceToken != null) {
      var tokens = _db
          .collection('deviceIdTokens')
          .document(deviceToken);
      await tokens.setData({
        'token': deviceToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    } });
    }

     _configureFirebaseListeners() { 
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
       
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _setMessage(message);
       
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
       _setMessage(message);
        
      },
     
      
    );
      _fcm.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );}

      _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];
    setState(() {
      Message msg = Message(title, body, mMessage);
      _messages.add(msg);
    });
    }


    void initState() {
      super.initState();
      // ignore: deprecated_member_use
      _messages = List<Message>();
      getToken();
      _configureFirebaseListeners();
    
     }
  
    





  @override
  Widget build(BuildContext context) {
    // _handleMessages(context);
    final _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
        body:ListView.builder(
        itemCount: null == _messages ? 0 : _messages.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
                child: Container(

                        child: Row(
                          children: <Widget>[
                        Image.asset ('images/notification.png', height: 50, width: 50,),
                         Padding(
                padding: EdgeInsets.all(30.0),
                
                child: Column(
                  children: [
                    Text(
                      _messages[index].message,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ),    
                           
                           
                           ],)
                      
                    
                  
             
               
             ),
          );
        },
      ),
  
          );
    
  }

}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
 
