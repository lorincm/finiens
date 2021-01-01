import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

//var globalContext;
List<String> worldcities;
List<String> currentCity;
double screenWidth;
double screenHeight;
LocationData currentLocation;
var location = new Location();
final double d_pi = 3.14159265358979323846;
double x;
double y;
double bearingTMP=0;
int bearingDiff;
int currentPlayer;
int playersCount;
int round;
String resultTitle;
List<String> players;
List<String> subT;
List<String> history = List();
List<int> historyRoundMissedBy = List();
List<int> historyRound = List();
List<Marker> markers = [];
String a;
double bearing(double lat1, double long1, double lat2, double long2) //1: device location 2: mit keresünk
{ 
  double dLon = (long2 - long1);
	double y = sin(dLon) * cos(lat2);
	double x = cos(lat1) * sin(lat2) - sin(lat1)*cos(lat2) * cos(dLon);

  double heading = atan2(y, x);

	heading = heading * 180 / d_pi;
	heading = (heading + 360) % 360;
	return heading;
}

Future<String> getFileData() async {
  return await rootBundle.loadString("assets/worldcities.csv");
}

int generateRandomNum(int listNum)
{
  var random = new Random();
  return random.nextInt(listNum);
}

var alertStyle = AlertStyle(
      
      animationType: AnimationType.grow,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      //animationDuration: Duration(milliseconds: 40),     
      titleStyle: TextStyle(
        color: Colors.black,
        fontFamily: "Segoe",
      ),
    );

//settings

bool countries = true;
bool heading = true;
bool roundQuestion = false;

addHistory() {

}