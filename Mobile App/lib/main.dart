import 'dart:async';
import 'dart:ui';
import 'package:flutter/src/painting/image_provider.dart';

import 'package:flutter/src/services/asset_bundle.dart';

import 'package:flutter/material.dart';
import 'iconButton.dart';
import './homepage.dart';

void main() =>runApp( MaterialApp(
    theme:
          ThemeData(primaryColor: Colors.red, accentColor: Colors.yellowAccent),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    
));
 
class SplashScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Splashscreenstate();
  }
}

class _Splashscreenstate extends State<SplashScreen> {
  void initState()
  {
    super.initState();
    Timer(Duration(seconds: 3),()=>runApp (MyApp()));
  }
   
 
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.green),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: Icon(
                            Icons.dashboard,
                            color: Colors.greenAccent,
                            size: 80,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Text(
                          "  Real Time Safety\nPrecaution System",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(backgroundColor: Colors.white,),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Text(
                        "System for Everyone",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      
    );
  }
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageButton(),
    );
  }
}


