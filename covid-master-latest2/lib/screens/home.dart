import 'package:app_settings/app_settings.dart';
import 'package:covid/helpers/screen_navigation.dart';
import 'package:covid/helpers/style.dart';
import 'package:covid/providers/bluetooth.dart';
import 'package:covid/screens/myapp.dart';
import 'package:covid/screens/test.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:covid/providers/auth.dart';
import 'enter_blue_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:covid/navigationDrawer/navigationDrawer.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
    final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    final blue = Provider.of<BlueToothProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: "Contact Tracing ", color: white,  size: 20, ),
          centerTitle: true,
          elevation: 0.5,
        ),
        drawer: navigationDrawer(),
        
        backgroundColor: white,
        body: blue.isOn ? Column(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/emu.png",
                  width: 100,
                ),


              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: "People Near You!", size: 24, weight: FontWeight.w300, color: primary,),
            ),

            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: blue.data, size: 18, weight: FontWeight.w300, color: grey),
              
              
            ),

            SizedBox(height: 5),
            IconButton(icon: Icon(Icons.add_location), onPressed: (){
              changeScreen(context, Blue());
            }),

            SizedBox(
              height: 10,
            ),
            
          ],
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/off.png",
                  width: 160,
                ),


              ],
            ),

            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your Bluetooth is turned off, please turn on the bluetooth and click on 'refresh'", textAlign: TextAlign.center, style: TextStyle(color: grey),),
            ),

            FlatButton.icon(onPressed: (){
              blue.turnOn();
              
            }, icon: Icon(Icons.refresh), label: CustomText(text: "refresh")),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        
      ),
    );
  }
    _subscribeToTopic() async {
    // Subscribe the user to a topic
    _fcm.subscribeToTopic('positive');
  }
}