/*class DHT22 {
   
  final double humidity;
  

  DHT22({ this.humidity});

  factory DHT22.fromHumidity(Map<dynamic,dynamic>json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT22(
       
        humidity: parser(json['Humidity']));
  }
}*/
class DHT22 {
  final int dht;
  List<dynamic> time=new List<dynamic>();
  
  DHT22(this.dht,this.time);

  DHT22.fromMap(Map<dynamic, dynamic> map)
      : assert(map['dht'] != null),
      assert(map['time'] != null),
        
        dht = map['dht'],
        time=map['time'];
       
        
}