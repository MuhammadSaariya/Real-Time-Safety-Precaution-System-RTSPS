

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




class GasSensor extends StatefulWidget {
    final Widget child;
    

  GasSensor({Key key, this.child}) : super(key: key);

  _GasSensorState createState() => _GasSensorState();
}

class _GasSensorState extends State<GasSensor> {
  List<charts.Series<Sensors, num>> _seriesDataCO;
  List<charts.Series<Sensors, num>> _seriesDataLPG;
  List<charts.Series<Sensors, num>> _seriesDataSmoke;
  _generateData() {
  var dataCO = [
      new Sensors(1, 127),
      new Sensors(2, 138),
      new Sensors(3, 164),
      new Sensors(4, 92),
      new Sensors(5, 156),
      new Sensors(6, 143),
      new Sensors(7, 65),
      new Sensors(8, 89),
      new Sensors(9, 114),
      new Sensors(10, 149),
      new Sensors(11, 128),
      new Sensors(12, 152),
      new Sensors(13, 132),
      new Sensors(14, 149),
      new Sensors(15, 79),
      new Sensors(16, 89),
      new Sensors(17, 119),
      new Sensors(18, 137),
      new Sensors(19, 146),
      new Sensors(20, 150),
    ];
    var dataLPG = [
      new Sensors(1, 114),
      new Sensors(2, 106),
      new Sensors(3, 192),
      new Sensors(4, 112),
      new Sensors(5, 91),
      new Sensors(6, 64),
      new Sensors(7, 87),
      new Sensors(8, 195),
      new Sensors(9, 85),
      new Sensors(10, 139),
      new Sensors(11, 148),
      new Sensors(12, 79),
      new Sensors(13, 99),
      new Sensors(14, 88),
      new Sensors(15, 119),
      new Sensors(16, 170),
      new Sensors(17, 196),
      new Sensors(18, 66),
      new Sensors(19, 144),
      new Sensors(20, 76),
    ];
    var dataSmoke = [
      new Sensors(1, 84),
      new Sensors(2, 167),
      new Sensors(3, 144),
      new Sensors(4, 188),
      new Sensors(5, 199),
      new Sensors(6, 114),
      new Sensors(7, 129),
      new Sensors(8, 70),
      new Sensors(9, 66),
      new Sensors(10, 135),
      new Sensors(11, 124),
      new Sensors(12, 178),
      new Sensors(13, 64),
      new Sensors(14, 119),
      new Sensors(15, 139),
      new Sensors(16, 156),
      new Sensors(17, 123),
      new Sensors(18, 84),
      new Sensors(19, 94),
      new Sensors(20, 128),
      
    ];
    _seriesDataCO.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2020',
        data: dataCO,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
    _seriesDataLPG.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2021',
        data: dataLPG,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
    _seriesDataSmoke.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2022',
        data: dataSmoke,
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
    _seriesDataCO = List<charts.Series<Sensors, num>>();
    _seriesDataLPG = List<charts.Series<Sensors, num>>();
    _seriesDataSmoke = List<charts.Series<Sensors, num>>();
    
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
                  'Gas ',
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
                                'CO    ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.LineChart(_seriesDataCO,
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
                                'LPG    ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.LineChart(_seriesDataLPG,
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
                                'Smoke    ',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.LineChart(_seriesDataSmoke,
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
  int month;

  int reading;

  Sensors(this.month, this.reading);
}

 


