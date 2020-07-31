import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutteranimatedchartsapp/Camera.dart';
import 'package:flutteranimatedchartsapp/Combined.dart';
import 'package:flutteranimatedchartsapp/Individual.dart';
import './homepage.dart';

class ImageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animated Charts App',
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => exit(0),
            
            //onPressed: () => exit(0),
          ),
          
          title: Text("RTSPS",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800),),
          actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.notifications_active,
        color: Colors.white,
      ),
      onPressed: () {
        // do something
      },
    )
  ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 30),
          //margin: EdgeInsets.all(20),
          //alignment: Alignment.center,
          width: 450,
          height: 640,
          color: Colors.black,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 150,
                  child: FlatButton(
                    child: Image.asset('assets/images.png'),
                    onPressed: () => runApp(CombinedGraph()),
                  ),
                ),
                SizedBox(
                  width: 180,
                  height: 150,
                  child: FlatButton(
                    child: Image.asset('assets/camera.jpg'),
                    onPressed: () => runApp(LiveFeed()),
                  ),
                ),
                SizedBox(
                  width: 190,
                  height: 140,
                  child: FlatButton(
                    child: Image.asset('assets/sensor.jpg'),
                    onPressed: () => runApp(IndividualGraph()),
                  ),
                )
              ]),

          //IconButton(icon: Icon(Icons.insert_chart,size: 100,color: Colors.pinkAccent,), onPressed: ()=>HomePage(),
        ),
      ),
    );
  }
}
