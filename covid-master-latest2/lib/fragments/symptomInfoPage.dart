import 'package:covid/fragments/symptomPage.dart';
import 'package:flutter/material.dart';
import 'package:covid/navigationDrawer/navigationDrawer.dart';
import 'package:covid/helpers/style.dart';
import 'package:covid/widgets/custom_button.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:covid/helpers/screen_navigation.dart';

class symptomInfoPage extends StatelessWidget {
 static const String routeName = '/symptomInfoPage';

 @override
 Widget build(BuildContext context) {
   return new Scaffold(
       appBar: AppBar(
         title: CustomText(text: "About Symptoms Survey ", color: white, size: 20),
          centerTitle: true,
          elevation: 0.5,
       ),
       drawer: navigationDrawer(),
body: Container(
          
          child: Column(
            
            children: <Widget>[
              SizedBox(height: 40),
              Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "images/co.png",
                            width: 160,
                          ),
                        ],
                      ),
              SizedBox(height: 40),
              Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Taking this Symptom Survey will assist you on deciding whether to seek testing or medical care if you suspect that you have contracted Covid-19 or have been in close contact with someone who has Covid-19',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: black,
                fontSize: 18.0,
              )),
        ),
              SizedBox(
                height: 48.0,
              ),
             
              CustomButton(
                msg: "Take Test",
                onTap: () {
                  changeScreenReplacement(context,  symptomPage());
                },
              ),
            ],
          ),
        )       );
 }
}