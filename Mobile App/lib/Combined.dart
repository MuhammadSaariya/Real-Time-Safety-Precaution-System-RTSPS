import 'dart:io';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutteranimatedchartsapp/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './iconButton.dart';

class CombinedGraph extends StatefulWidget {
  final Widget child;

  CombinedGraph({Key key, this.child}) : super(key: key);

  _CombinedGraphState createState() => _CombinedGraphState();
}

class _CombinedGraphState extends State<CombinedGraph> {
  List<charts.Series<Sensors, String>> _seriesData;
  
  // List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {
    var data1 = [
      new Sensors('1', 30),
      new Sensors('2', 30),
      new Sensors('3', 35),
      new Sensors('4', 37),
      new Sensors('5', 37),
      new Sensors('6', 36),
      new Sensors('7', 36),
      new Sensors('8', 38),
      new Sensors('9', 39),
      new Sensors('10', 38),
    ];
    var data2 = [
     new Sensors('1', 0),
      new Sensors('2', 0),
      new Sensors('3', 1),
      new Sensors('4', 1),
      new Sensors('5', 1),
      new Sensors('6', 0),
      new Sensors('7', 0),
      new Sensors('8', 0),
      new Sensors('9', 0),
      new Sensors('10', 0),
    ];
    var data3 = [
     new Sensors('1', 127),
      new Sensors('2', 138),
      new Sensors('3', 164),
      new Sensors('4', 92),
      new Sensors('5', 156),
      new Sensors('6', 143),
      new Sensors('7', 65),
      new Sensors('8', 89),
      new Sensors('9', 114),
      new Sensors('10', 149),
    ];
     var data = [
      new Sensors('1', 1.167),
      new Sensors('2', 0.993),
      new Sensors('3', 0.569),
      new Sensors('4', 0.783),
      new Sensors('5', 1.245),
      new Sensors('6', 0.834),
      new Sensors('7', 0.952),
      new Sensors('8', 1.167),
      new Sensors('9', 0.993),
      new Sensors('10', 0.569),
    ];

    

    _seriesData.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2018',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2019',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2020',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );
    _seriesData.add(
      charts.Series(
        domainFn: (Sensors sensors, _) => sensors.month,
        measureFn: (Sensors sensors, _) => sensors.reading,
        id: '2021',
        data: data,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Sensors sensors, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Sensors, String>>();
    
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.purple,
        accentColor: Colors.cyan[600],
      ),
      home: DefaultTabController(
        length: 3,
        
                  child: Scaffold(
            
            
            appBar: AppBar(
              automaticallyImplyLeading: false,
                //`true` if you want Flutter to automatically add Back Button when needed,
                //or `false` if you want to force your own back button every where
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed:() => runApp(ImageButton()),
                  //onPressed: () => exit(0),
                ),
                backgroundColor: Colors.pink,
                
                title: Center(
                  child: Text(
                    'RTSPS  ',
                    style: TextStyle(
                        fontSize: 50,
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
                                'Graphs of all sensors',
                                style: TextStyle(
                                    fontSize: 24.0, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: charts.BarChart(
                                  _seriesData,
                                  animate: true,
                                  barGroupingType: charts.BarGroupingType.grouped,
                                  //behaviors: [new charts.SeriesLegend()],
                                  animationDuration: Duration(seconds: 2),
                                ),
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
  String month;

  double reading;

  Sensors(this.month, this.reading);
}


