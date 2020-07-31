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




class FlameSensor extends StatefulWidget {
    final Widget child;
    

  FlameSensor({Key key, this.child}) : super(key: key);

  _GasSensorState createState() => _GasSensorState();
}

class _GasSensorState extends State<FlameSensor> {
  List<charts.Series<Sensors, num>> _seriesDataFlame;
  
  _generateData() {
  var dataFlame = [
    new Sensors(1, 0),
      new Sensors(2, 0),
      new Sensors(3, 1),
      new Sensors(4, 1),
      new Sensors(5, 1),
      new Sensors(6, 0),
      new Sensors(7, 0),
      new Sensors(8, 0),
      new Sensors(9, 0),
      new Sensors(10, 0),
      new Sensors(11, 0),
      new Sensors(12, 0),
       new Sensors(13,0 ),
      new Sensors(14, 0),
      new Sensors(15, 0),
      new Sensors(16, 0),
      new Sensors(17, 0),
      new Sensors(18, 0),
      new Sensors(19, 0),
      new Sensors(20, 0),
    ];
    
    _seriesDataFlame.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2020',
        data: dataFlame,
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
    _seriesDataFlame = List<charts.Series<Sensors, num>>();
    
    
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
                  'Flame ',
                  style: TextStyle(
                      fontSize: 35,
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
                                'Flame    ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.LineChart(_seriesDataFlame,
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