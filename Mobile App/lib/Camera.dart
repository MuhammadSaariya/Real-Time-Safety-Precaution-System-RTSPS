import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import './iconButton.dart';
class LiveFeed extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: CameraFeed(),
    );
  }
}

class CameraFeed extends StatefulWidget {
  final Widget child;

  CameraFeed({Key key, this.child}) : super(key: key);

  _CameraFeedState createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  String _streamUrl;
  VlcPlayerController _vlcViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vlcViewController = new VlcPlayerController();
  }

 void _incrementCounter() {
    setState(() {
      if (_streamUrl != null) {
        _streamUrl = null;
      } else {
        _streamUrl = 'http://192.168.1.4:8081';
      }
    });
  }
 

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              
              body: Container(
                
                
                
                              child: Center(    
                       child: Column(
                         
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           Text('Live Feed',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                 
            _streamUrl == null
                  ? Container(
                      child: Center(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Stream Closed',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  background: Paint()..color = Colors.red),
                            )
                          ]),
                        ),
                      ),
                    )
                  : new VlcPlayer(
                      defaultHeight: 480,
                      defaultWidth: 640,
                      url: _streamUrl,
                      controller: _vlcViewController,
                      placeholder: Container(),
                    )
          ],
        ),
      ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(_streamUrl == null ? Icons.play_arrow : Icons.pause),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ),
         /* body: Column(
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
                            'Live Feed',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ),
              ),
             
            ],
          ),*/
        ),
      
    );
  }
}

