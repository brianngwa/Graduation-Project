import 'package:flutter/material.dart';
import 'package:covid/routes/pagerRoute.dart';
import 'package:covid/navigationDrawer/createDrawerHeader.dart';
import 'package:covid/widgets/createDrawerBodyItem.dart';

class navigationDrawer extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       children: <Widget>[
         createDrawerHeader(),
         createDrawerBodyItem(
           icon: Icons.bluetooth_audio_outlined,
           text: 'Contact Tracing',
           onTap: () =>
               Navigator.pushReplacementNamed(context, pageRoutes.home),
         ),
          createDrawerBodyItem(
           icon: Icons.library_books_outlined,
           text: 'Symtoms Survey',
           onTap: () =>
               Navigator.pushReplacementNamed(context, pageRoutes.symptom),
         ),
         createDrawerBodyItem(
           icon: Icons.upload_outlined ,
           text: 'upload PCR',
           onTap: () =>
               Navigator.pushReplacementNamed(context, pageRoutes.pcr),
         ),
          createDrawerBodyItem(
           icon: Icons.health_and_safety_outlined  ,
           text: 'BMI Calculator',
           onTap: () =>
               Navigator.pushReplacementNamed(context, pageRoutes.pcr),
         ),
     

     
         Divider(),
         createDrawerBodyItem(
           icon: Icons.notifications_active,
           text: 'Notifications',
           onTap: () =>
               Navigator.pushReplacementNamed(context, pageRoutes.notification),
         ),
           createDrawerBodyItem(
           icon: Icons.info_outline_rounded  ,
           text: 'About App',
           onTap: () =>
               Navigator.pushReplacementNamed(context, null),
         ),
        
         ListTile(
           title: Text('Cyprus Contact Tracing App'),
           onTap: () {},
         ),
       ],
     ),
   );
 }
}