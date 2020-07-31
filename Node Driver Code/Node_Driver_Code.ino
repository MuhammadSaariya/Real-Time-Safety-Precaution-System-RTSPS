#include <ArduinoJson.h>
#include <SoftwareSerial.h>
#include <dht.h>
#include <MQ2.h>
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
SoftwareSerial dustSerial(D6);MQ2 mq2 (A0);dht DHT;
const long utcOffsetInSeconds = 18000;WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "asia.pool.ntp.org", utcOffsetInSeconds);
#define WIFI_SSID "NoPassword4u!"
#define WIFI_PASSWORD "maravien"
#define FIREBASE_HOST "rtsps2020.firebaseio.com"
#define FIREBASE_AUTH "G6fIgHJXTX7Pj0ZuycWNx447QM7KVujZRpqrKeSU"
void setup()
{
  Serial.begin(9600);
  mq2.begin ();
  dustSerial.begin(9600);
  wifiConnect();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  timeClient.begin();
  delay(5000);
}
void loop()
{
    if(WiFi.status() != WL_CONNECTED){
      wifiConnect();
    }
    timeClient.update();
    int readData = DHT.read22(D1);
    float t = DHT.temperature;
    float h = DHT.humidity;
    int f = digitalRead(D0);
    int LPG = mq2.readLPG(); int lpg;
    int CO = mq2.readCO(); int co;
    int SMOKE = mq2.readSmoke(); int smoke;
    Serial.print("LPG : ");
    Serial.print(lpg);
    Serial.print("    | CO : ");
    Serial.print(co);
    Serial.print("    | Smoke : ");
    Serial.println(smoke);
    Serial.print ("Flame : ");
    Serial.println (f);
    Serial.print("Temperature = ");
    Serial.print(t);
    Serial.print(" ");
    Serial.print("°C | ");
    Serial.print((t * 9.0) / 5.0 + 32.0);//print the temperature in Fahrenheit
    Serial.print(" ");
    Serial.println("°F ");
    Serial.print("Humidity = ");
    Serial.print(h);
    Serial.println(" % ");;
    float v = dustSerial.read();
    float vo = v * (5/1024);
    float dd = 0.17 * vo;
    Serial.print("Dust Density =  ");
    Serial.print(dd);
    Serial.println(" ug/m3");
    String Month;
    String Date;
    String Hour;
    String Minute;
    String Second;
    if (timeClient.getMonth() < 10)
    {
      Month = String("0") + String(timeClient.getMonth());
    }
    else
    {
      Month = String(timeClient.getMonth());
    }
    Date = String(timeClient.getDate());
    if (timeClient.getHours() < 10)
    {
      Hour = String("0") + String(timeClient.getHours());
    }
    else
    {
      Hour = String(timeClient.getHours());
    }
    if (timeClient.getMinutes() < 10)
    {
      Minute = String("0") + String(timeClient.getMinutes());
    }
    else
    {
      Minute = String(timeClient.getMinutes());
    }
    if (timeClient.getSeconds() < 10)
    {
      Second = String("0") + String(timeClient.getSeconds());
    }
    else
    {
      Second = String(timeClient.getSeconds());
    }
    String firebaseT = String(t) + String("°C");
    String firebaseH = String(h) + String("%");
    String firebaseF = String(f);
    String firebaseLPG = String(lpg) + String("ppm");
    String firebaseCO = String(co) + String("ppm");
    String firebaseS = String(smoke) + String("ppm");
    //String firebaseVO = String(vo) + String("mV");
    String firebaseD = String(dd) + String("ug/m^3");
    String pDHT22TempFuzzy = String("/DHT22F/Temperature/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    String pDHT22HumFuzzy = String("/DHT22F/Humidity/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    String pFlameFuzzy = String("/FlameF/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    String pGasCOFuzzy = String("/GasF/CO/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    String pGasLPGFuzzy = String("/GasF/LPG/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    String pGasSmokeFuzzy = String("/GasF/Smoke/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    //String pDustVoltFuzzy = String("/DustF/OutVoltage/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    String pDustDenFuzzy = String("/DustF/Density/") + String(timeClient.getYear()) + String("/") + Month + String("/") + Date + String("/") + Hour + String("/") + Minute + String("/") + Second;
    if (Firebase.success()){
      // Apps Data
      Firebase.pushString("/DHT22/Temperature",firebaseT);
      Firebase.pushString("/DHT22/Humidity",firebaseH);
      Firebase.pushString("/Flame",firebaseF);
      Firebase.pushString("/Gas/CO",firebaseCO);
      Firebase.pushString("/Gas/LPG",firebaseLPG);
      Firebase.pushString("/Gas/Smoke",firebaseS);
      //Firebase.pushString("/Dust/OutVoltage",firebaseVO);
      Firebase.pushString("/Dust/Density",firebaseD);
      // Fuzzy Data
      Firebase.setString(pDHT22TempFuzzy,firebaseT);
      Firebase.setString(pDHT22HumFuzzy,firebaseH);
      Firebase.setString(pFlameFuzzy,firebaseF);
      Firebase.setString(pGasCOFuzzy,firebaseCO);
      Firebase.setString(pGasLPGFuzzy,firebaseLPG);
      Firebase.setString(pGasSmokeFuzzy,firebaseS);
      //Firebase.setString(pDustVoltFuzzy,firebaseVO);
      Firebase.setString(pDustDenFuzzy,firebaseD);
    }
}
void wifiConnect()
{
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);             // Connect to the network
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID); Serial.println(" ...");

  int teller = 0;
  while (WiFi.status() != WL_CONNECTED)
  {                                       // Wait for the Wi-Fi to connect
    delay(1000);
    Serial.print(++teller); Serial.print(' ');
  }

  Serial.println('\n');
  Serial.println("Connection established!");  
  Serial.print("IP address:\t");
  Serial.println(WiFi.localIP());         // Send the IP address of the ESP8266 to the computer
}
