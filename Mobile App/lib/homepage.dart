import 'dart:io';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutteranimatedchartsapp/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './iconButton.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Sensors, String>> _seriesData;
  // List<charts.Series<Task, String>> _seriesPieData;
 

  _generateData() {
    var data1 = [
      new Sensors('Jan', 30),
      new Sensors('Feb', 40),
      new Sensors('Mar', 10),
      new Sensors('Apr', 20),
      new Sensors('May', 25),
      new Sensors('Jun', 35),
      new Sensors('Jul', 45),
      new Sensors('Aug', 55),
      new Sensors('Sept', 60),
      new Sensors('Oct', 15),
      new Sensors('Nov', 25),
      new Sensors('Dec', 10),
    ];
    var data2 = [
      new Sensors('Jan', 30),
      new Sensors('Feb', 20),
      new Sensors('Mar', 40),
      new Sensors('Apr', 50),
      new Sensors('May', 25),
      new Sensors('Jun', 65),
      new Sensors('Jul', 45),
      new Sensors('Aug', 75),
      new Sensors('Sept', 200),
      new Sensors('Oct', 151),
      new Sensors('Nov', 252),
      new Sensors('Dec', 101),
    ];
    var data3 = [
      new Sensors('Jan', 30),
      new Sensors('Feb', 40),
      new Sensors('Mar', 10),
      new Sensors('Apr', 20),
      new Sensors('May', 25),
      new Sensors('Jun', 35),
      new Sensors('Jul', 45),
      new Sensors('Aug', 55),
      new Sensors('Sept', 60),
      new Sensors('Oct', 15),
      new Sensors('Nov', 25),
      new Sensors('Dec', 10),
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
              bottom: TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Icon(FontAwesomeIcons.solidChartBar),
                  ),
                  Tab(icon: Icon(FontAwesomeIcons.camera)),
                  Tab(icon: Icon(FontAwesomeIcons.chartLine)),
                ],
              ),
              
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
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Sensors dummy reading',
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Live Feed',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'sensors dummy reading',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        
                      ],
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

  int reading;

  Sensors(this.month, this.reading);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Range {
  int monthval;
  int readval;

  Range(this.monthval, this.readval);
}
