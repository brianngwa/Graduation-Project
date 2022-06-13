import 'package:covid/helpers/screen_navigation.dart';
import 'package:covid/helpers/style.dart';
import 'package:covid/screens/login.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';


class OnBoarding extends StatelessWidget {
  final pageList = [

    PageModel(
        color: white,
        heroAssetPath: 'images/social.png',
        title: Text('How it works?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('If a student in the CMPE departement is tested positive for covid-19, we will retrieve the users that have been in contact with this person for the past 30 days',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),

    PageModel(
        color: white,
        heroAssetPath: 'images/q.png',
        title: Text('Close contact',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Everytime you come to close contact with another user, those exposures will be safely stored in our database.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),

    PageModel(
        color: white,
        heroAssetPath: 'images/mobile.png',
        title: Text('Easy Sign in',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: primary,
              fontSize: 34.0,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('You can easily sign in to the app by entering your phone number ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: grey,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/circle.png'
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FancyOnBoarding(
            doneButtonBackgroundColor: primary,
            doneButtonText: "Done",
            pageList: pageList,
            onDoneButtonPressed: () =>
                changeScreenReplacement(context, Login()),
            onSkipButtonPressed: () =>
                changeScreenReplacement(context, Login()),
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomText(text: "< swipe left", color: grey.withOpacity(0.5),)),)
        ],
      ),
    );
  }
}
