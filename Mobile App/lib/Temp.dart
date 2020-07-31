// import 'dart:async';
// import 'dart:math';

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutteranimatedchartsapp/Combined.dart';
// import 'package:flutteranimatedchartsapp/Individual.dart';

// import 'dart:io';
// import 'package:charts_flutter/flutter.dart' as charts;

// import './Individual.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter_icons/flutter_icons.dart';

// import 'package:wave_progress_widget/wave_progress_widget.dart';
// //import './DHT22.dart';
// import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';

// class Sensor {
//   num month;

//   double reading;

//   Sensor(this.month, this.reading);
// }

// class TempSensor extends StatefulWidget {
//   _TempSensorState createState() => _TempSensorState();
// }

// class _TempSensorState extends State<TempSensor> {
//   var _seriesData = List<charts.Series<Sensor, num>>();
//   var _seriesData1 = List<charts.Series<Sensor, num>>();

//   var data1 = new List<Sensor>();
//   var data2 = new List<Sensor>();
//   final fb = FirebaseDatabase.instance;
  
//   bool val;

//   Widget build(BuildContext context) {
    

//     final ref = fb.reference();
// int i=0;
// int n=0;
//     ref.child("DHT22").child("Humidity").onChildAdded.listen((event) {
      
//       val=true;
//       var snapshot = event.snapshot;
      
     
//       if(val==true)       

//       setState(() {
//         // dht.add(snapshot.value);
//         // time.add(DateTime.now());str1.substring(0,str1.length-1)   
        
//           data1.add(new Sensor(
//               DateTime.now().minute,
//               double.parse(
//                   snapshot.value.substring(0, snapshot.value.length - 1))));
//                   _seriesData.add(
//           charts.Series(
//             domainFn: (Sensor sensor, _) => sensor.month,
//             measureFn: (Sensor sensor, _) => sensor.reading,
//             id: 'humidity',
//             data: data1,
//             fillPatternFn: (_, __) => charts.FillPatternType.solid,
//             fillColorFn: (Sensor sensor, _) =>
//                 charts.ColorUtil.fromDartColor(Color(0xff990099)),
//           ),
//         ); 
 
//       });
      
      
     
//     }
    
//     );
//     ref.child("DHT22").child("Temperature").onChildAdded.listen((event) {
      
//       val=true;
//       var snapshot = event.snapshot;
      
     
//       if(val==true)       

//       setState(() {
//         // dht.add(snapshot.value);
//         // time.add(DateTime.now());str1.substring(0,str1.length-1)   
        
//           data2.add(new Sensor(
//               DateTime.now().minute,
//               double.parse(
//                   snapshot.value.substring(0, snapshot.value.length - 2))));
//                   _seriesData1.add(
//           charts.Series(
//             domainFn: (Sensor sensor, _) => sensor.month,
//             measureFn: (Sensor sensor, _) => sensor.reading,
//             id: 'temperature',
//             data: data2,
//             fillPatternFn: (_, __) => charts.FillPatternType.solid,
//             fillColorFn: (Sensor sensor, _) =>
//                 charts.ColorUtil.fromDartColor(Color(0xff990099)),
//           ),
//         ); 
//       });   
//     } 
//     );
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: true,
//             //`true` if you want Flutter to automatically add Back Button when needed,
//             //or `false` if you want to force your own back button every where
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: () => runApp(IndividualGraph()),
//               //onPressed: () => exit(0),
//             ),
//             backgroundColor: Colors.pink,
//             title: Center(
//               child: Text(
//                 'Temperature & Humidity  ',
//                 style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                     fontStyle: FontStyle.italic,
//                     color: Colors.white),
//               ),
//             ),
//           ),
//           body: Column(
//             children: [
//               SizedBox(
//                 height: 300,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             ' Humidity ',
//                             style: TextStyle(
//                                 fontSize: 24.0, fontWeight: FontWeight.bold),
//                           ),
//                           Expanded(
//                             child: charts.LineChart(_seriesData, 
//                                 defaultRenderer:
//                                         new charts.LineRendererConfig(
//                                             includeArea: true, stacked: true),
//                                 animate: false,
//                                 animationDuration: Duration(seconds: 2),
//                                 behaviors: [
//                                   new charts.ChartTitle('Time',
//                                       behaviorPosition:
//                                           charts.BehaviorPosition.bottom,
//                                       titleOutsideJustification: charts
//                                           .OutsideJustification.middleDrawArea),
//                                   new charts.ChartTitle('Range',
//                                       behaviorPosition:
//                                           charts.BehaviorPosition.start,
//                                       titleOutsideJustification: charts
//                                           .OutsideJustification.middleDrawArea),
//                                 ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 300,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             ' Temperature ',
//                             style: TextStyle(
//                                 fontSize: 24.0, fontWeight: FontWeight.bold),
//                           ),
//                           Expanded(
//                             child: charts.LineChart(_seriesData1, 
//                                 defaultRenderer:
//                                         new charts.LineRendererConfig(
//                                             includeArea: true, stacked: true),
//                                 animate: false,
//                                 animationDuration: Duration(seconds: 2),
//                                 behaviors: [
//                                   new charts.ChartTitle('Time',
//                                       behaviorPosition:
//                                           charts.BehaviorPosition.bottom,
//                                       titleOutsideJustification: charts
//                                           .OutsideJustification.middleDrawArea),
//                                   new charts.ChartTitle('Range',
//                                       behaviorPosition:
//                                           charts.BehaviorPosition.start,
//                                       titleOutsideJustification: charts
//                                           .OutsideJustification.middleDrawArea),
//                                 ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// //return  mainScaffold();

// /*  Widget mainScaffold() {
//     return Scaffold(
      
         
       
                 
                   
//       );
//   }*/

// /*List<charts.Series<DHT22, int>> _seriesData;
//   List<DHT22> mydata;
//   DatabaseReference _dhtRef =
//       FirebaseDatabase.instance.reference().child('DHT22');
//   _generateData(mydata) {
    
//     _seriesData = List<charts.Series<DHT22, int>>();
//     _seriesData.add(
//       charts.Series(
//         domainFn: (DHT22 dht22, _) => dht22.month,
//         measureFn: (DHT22 dht22, _) => dht22.reading,
        
//         id: 'Reading',
//         data: mydata,
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Reading')),
//       body: _buildBody(context),
//     );
//   }
//   Widget _buildBody(BuildContext context) {
//     return StreamBuilder(
//       stream: _dhtRef.onValue,
//                 builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return LinearProgressIndicator();
//         } else {
//           List<DHT22> dht22 = snapshot.data.documents
//               .map((documentSnapshot) => DHT22.fromMap(documentSnapshot.data))
//               .toList();
//           return _buildChart(context, dht22);
//         }
//       },
//     );
//   }
//    Widget _buildChart(BuildContext context, List<DHT22> tempdata) {
//     mydata = tempdata;
//     _generateData(mydata);
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Container(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Text(
//                 'Temperature',
//                 style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Expanded(
//                                 child: charts.LineChart(_seriesData,
//                                     defaultRenderer:
//                                         new charts.LineRendererConfig(
//                                             includeArea: true, stacked: true),
//                                     animate: true,
//                                     animationDuration: Duration(seconds: 2),
//                                     behaviors: [
//                                       new charts.ChartTitle('Months',
//                                           behaviorPosition:
//                                               charts.BehaviorPosition.bottom,
//                                           titleOutsideJustification: charts
//                                               .OutsideJustification
//                                               .middleDrawArea),
//                                       new charts.ChartTitle('Range',
//                                           behaviorPosition:
//                                               charts.BehaviorPosition.start,
//                                           titleOutsideJustification: charts
//                                               .OutsideJustification
//                                               .middleDrawArea),
//                                     ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }*/

// /*@override
//   Widget build(BuildContext context) {
    
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//               //`true` if you want Flutter to automatically add Back Button when needed,
//               //or `false` if you want to force your own back button every where
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back_ios),
//                 onPressed:() => runApp(IndividualGraph()),
//                 //onPressed: () => exit(0),
//               ),
//               backgroundColor: Colors.pink,
              
//               title: Center(
//                 child: Text(
//                   'Temperature & Humidity  ',
//                   style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2,
//                       fontStyle: FontStyle.italic,
//                       color: Colors.white),
//                 ),
//               ),
//               ),
//           body: Column (
//               children: [
                
//                 SizedBox(
//                   height: 600,
//                                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Container(
//                       child: Center(
    
//                        child: Column(
//                             children: <Widget>[
//                               Text(
//                                 'Temperature  ',
//                                 style: TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Expanded(
//                                 child: charts.LineChart(_seriesData1,
//                                     defaultRenderer:
//                                         new charts.LineRendererConfig(
//                                             includeArea: true, stacked: true),
//                                     animate: true,
//                                     animationDuration: Duration(seconds: 2),
//                                     behaviors: [
//                                       new charts.ChartTitle('Months',
//                                           behaviorPosition:
//                                               charts.BehaviorPosition.bottom,
//                                           titleOutsideJustification: charts
//                                               .OutsideJustification
//                                               .middleDrawArea),
//                                       new charts.ChartTitle('Range',
//                                           behaviorPosition:
//                                               charts.BehaviorPosition.start,
//                                           titleOutsideJustification: charts
//                                               .OutsideJustification
//                                               .middleDrawArea),
//                                     ]),
//                               ),
//                               Text(
//                                 'Humidity  ',
//                                 style: TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Expanded(
//                                 child: charts.LineChart(_seriesData2,
//                                     defaultRenderer:
//                                         new charts.LineRendererConfig(
//                                             includeArea: true, stacked: true),
//                                     animate: true,
//                                     animationDuration: Duration(seconds: 2),
//                                     behaviors: [
//                                       new charts.ChartTitle('Months',
//                                           behaviorPosition:
//                                               charts.BehaviorPosition.bottom,
//                                           titleOutsideJustification: charts
//                                               .OutsideJustification
//                                               .middleDrawArea),
//                                       new charts.ChartTitle('Range',
//                                           behaviorPosition:
//                                               charts.BehaviorPosition.start,
//                                           titleOutsideJustification: charts
//                                               .OutsideJustification
//                                               .middleDrawArea),
//                                     ]),
//                               ),
//                             ],
//                           ),
//                       ),
//                     ),
//                                   ),
//                 ),
//               ],
//         ),
//         ),
//       ),
      
//     );
//   }
// }*/
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutteranimatedchartsapp/Combined.dart';
import 'package:flutteranimatedchartsapp/Individual.dart';
import './homepage.dart';
import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutteranimatedchartsapp/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './iconButton.dart';
import './Individual.dart';
import 'package:firebase_database/firebase_database.dart';




class TempSensor extends StatefulWidget {
    final Widget child;
    

  TempSensor({Key key, this.child}) : super(key: key);

  _GasSensorState createState() => _GasSensorState();
}

class _GasSensorState extends State<TempSensor> {
  List<charts.Series<Sensors, num>> _seriesDatatemp;
  List<charts.Series<Sensors, num>> _seriesDataHumidity;
  
  _generateData() {
  var datatemp = [
     new Sensors(1, 30),
      new Sensors(2, 30),
      new Sensors(3, 35),
      new Sensors(4, 37),
      new Sensors(5, 37),
      new Sensors(6, 36),
      new Sensors(7, 36),
      new Sensors(8, 38),
      new Sensors(9, 39),
      new Sensors(10, 38),
      new Sensors(11, 37),
      new Sensors(12, 38),
      new Sensors(13, 37),
      new Sensors(14, 36),
      new Sensors(15, 36),
      new Sensors(16, 38),
      new Sensors(17, 39),
      new Sensors(18, 38),
      new Sensors(19, 37),
      new Sensors(20, 38),
    ];
    var dataHumidity = [
     new Sensors(1, 54.9),
      new Sensors(2, 54.9),
      new Sensors(3, 54.9),
      new Sensors(4, 54.9),
      new Sensors(5, 55.1),
      new Sensors(6, 55.1),
      new Sensors(7, 55.0),
      new Sensors(8, 55.2),
      new Sensors(9, 55.1),
      new Sensors(10, 55.1),
      new Sensors(11, 54.8),
      new Sensors(12, 54.9),
      new Sensors(13, 55.1),
      new Sensors(14, 55.1),
      new Sensors(15, 55.0),
      new Sensors(16, 55.2),
      new Sensors(16, 55.1),
      new Sensors(17, 55.1),
      new Sensors(18, 54.8),
      new Sensors(19, 54.9),
      new Sensors(20, 55.1),
    ];
    
    _seriesDatatemp.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2020',
        data: datatemp,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
     _seriesDataHumidity.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2020',
        data: dataHumidity,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
    
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesDatatemp = List<charts.Series<Sensors, num>>();
    _seriesDataHumidity= List<charts.Series<Sensors, num>>();
    
    
    _generateData();
  }
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
              //`true` if you want Flutter to automatically add Back Button when needed,
              //or `false` if you want to force your own back button every where
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed:() => runApp(IndividualGraph()),
                //onPressed: () => exit(0),
              ),
              backgroundColor: Colors.pink,
              
              title: Center(
                child: Text(
                  'Temperature & Humidity ',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              ),
             
          body: Column (
              children: [
                
                SizedBox(
                  height: 600,
                                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      child: Center(
    
                       child: Column(
                            children: <Widget>[
                              Text(
                                'Temperature    ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.LineChart(_seriesDatatemp,
                                    defaultRenderer:
                                        new charts.LineRendererConfig(
                                            includeArea: true, stacked: true),
                                    animate: true,
                                    animationDuration: Duration(seconds: 2),
                                    behaviors: [
                                      new charts.ChartTitle('Time',
                                          behaviorPosition:
                                              charts.BehaviorPosition.bottom,
                                          titleOutsideJustification: charts
                                              .OutsideJustification
                                              .middleDrawArea),
                                      new charts.ChartTitle('Range',
                                          behaviorPosition:
                                              charts.BehaviorPosition.start,
                                          titleOutsideJustification: charts
                                              .OutsideJustification
                                              .middleDrawArea),
                                    ]),
                              ),
                                Text(
                                'Humidity    ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.LineChart(_seriesDataHumidity,
                                    defaultRenderer:
                                        new charts.LineRendererConfig(
                                            includeArea: true, stacked: true),
                                    animate: true,
                                    animationDuration: Duration(seconds: 2),
                                    behaviors: [
                                      new charts.ChartTitle('Time',
                                          behaviorPosition:
                                              charts.BehaviorPosition.bottom,
                                          titleOutsideJustification: charts
                                              .OutsideJustification
                                              .middleDrawArea),
                                      new charts.ChartTitle('Range',
                                          behaviorPosition:
                                              charts.BehaviorPosition.start,
                                          titleOutsideJustification: charts
                                              .OutsideJustification
                                              .middleDrawArea),
                                    ]),
                              ),
                             
                            ],
                          ),
                      ),
                    ),
                                  ),
                ),
               
              ],
          ),
        ),
      ),
      
    );
  }
}



class Sensors {
  num month;

  double reading;

  Sensors(this.month, this.reading);
}
