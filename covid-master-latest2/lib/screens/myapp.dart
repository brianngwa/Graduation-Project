import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:covid/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'enter_blue_address.dart';
import 'package:covid/providers/bluetooth.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:covid/helpers/style.dart';
void main() => runApp(new Blue());

class Blue extends StatefulWidget {
  @override
  BlueState createState() => new BlueState();
}

class BlueState extends State<Blue> {
  String _data = '';
  List <String> _connection_list = [''];
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  

  @override
  
  void initState() {
    
    _bluetooth.devices.listen((device) {
      if (this.mounted) {
      setState(() {
        _data += device.name+' (${device.address})'+',';
        _connection_list = _data.split(',') ;
        _connection_list = _connection_list.toSet().toList();}
        
        
        
      );
      }
     
       
    });

    _bluetooth.scanStopped.listen((device) {
     if (this.mounted) {
      setState(() {
        _scanning = false;
        
       
        
      });
    }});
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final blue = Provider.of<BlueToothProvider>(context);
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
            title: CustomText(text: "Start Scan ", color: white, size: 20),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: <Widget>[
             SizedBox(height: 30),
            Expanded(child: Text(_data)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RaisedButton(child: Text(_scanning ? 'Stop scan' : 'Start scan'), onPressed: () async {
                  try {
                  
                    if(_scanning) {
                      
                      await _bluetooth.stopScan();
                      
                      debugPrint("scanning stopped");
                      if (this.mounted) {
                      setState(() {
                        
                        _data = '';
                        
                      
                      });}
                    }
                    else {
                      await _bluetooth.startScan(pairedDevices: false);
                      
                      debugPrint("scanning started");
                      print(_connection_list);
                      auth.setCloseContacts(
                      id: auth.user.uid,
                      closeContacts: _connection_list,
                      );
                      
                      
                     
                       
                      if (this.mounted) {
                      setState(() {
                        _scanning = true;
                    
                      });}
                    }
                  } on PlatformException catch (e) {
                    debugPrint(e.toString());
                  }
                 
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}