import 'package:covid/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:covid/navigationDrawer/navigationDrawer.dart';
import 'package:covid/helpers/style.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class uploadpcrPage extends StatefulWidget {
 static const String routeName = '/uploadpcrPage';

  @override
  State<StatefulWidget> createState() {
     // TODO: implement createState
    return _uploadpcrState();} }

class _uploadpcrState extends State<uploadpcrPage> {
  final Firestore _db = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  final _controller = TextEditingController();
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String firstname = "";
   @override
  void initState() {
    super.initState();
    uploadInfo();
    
    }
  
 @override
 Widget build(BuildContext context) {
   final auth = Provider.of<AuthProvider>(context);
   
    
   return new Scaffold(
       appBar: AppBar(
         title: CustomText(text: "Upload PCR ", color: white, size: 20),
          centerTitle: true,
          elevation: 0.5,
       ),
       drawer: navigationDrawer(),
       body: Column(
         
         children: [
           SizedBox(height: 20),
         Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "images/pos.png",
                            width: 160,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('If you have tested positive for Covid-19. Input your name to quickly notify your exposures list.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: black,
                fontSize: 18.0,
              )),
        ),
        SizedBox(height: 30),
         Text(firstname),
         
         Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
           child: TextField(
             decoration: InputDecoration(
              border: InputBorder.none,
                                    hintText: "input your name",
                                    hintStyle: TextStyle(
                                        color: grey,
                                        fontFamily: "Sen",
                                        fontSize: 18,
                                        
                                         )
             ),
             keyboardType: TextInputType.name,
             controller: _controller,
           ),
         ),
         
         ElevatedButton(onPressed: (){
           setState((){  firstname = _controller.text;
           });
           print(firstname);
           uploadInfo();
          
                      }, child: Text("Submit"))

       ],) 
       );
       
 }
 
  


 uploadInfo()  async{
     FirebaseUser _user = await _auth.currentUser();
    
     
      
       if (_user.uid != null) {
      var positive = _db
          .collection('positive')
          .document(firstname);
         
      await positive.setData({
        'Name': firstname,
        
      });
    } 
    }
 
    
    }