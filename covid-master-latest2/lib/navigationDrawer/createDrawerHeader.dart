import 'package:flutter/material.dart';

Widget createDrawerHeader() {
 return DrawerHeader(
     margin: EdgeInsets.zero,
     padding: EdgeInsets.zero,
     
     child: Stack(children: <Widget>[
       Positioned(
           bottom: 12.0,
           left: 16.0,
           child: Text("Cyprus Covid Tracing",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 20.0,
                   fontWeight: FontWeight.w500))),
     ]));
}