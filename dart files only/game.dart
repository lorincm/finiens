import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:simple_flutter_compass/simple_flutter_compass.dart';
import 'package:testing_asd/history.dart';
import 'package:testing_asd/settings.dart';
import 'dart:async' show Future;
import "globals.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


/*
                onPressed: () {
                  _simpleFlutterCompass.stopListen().then((v) {
                    //listen request stop
                  });
                },

                onPressed: () async {
                  _simpleFlutterCompass.listen().then((v) {
                    //listen request
                  });
*/

void addMarkers()
{
  markers.clear();
  markers.add(
      Marker(
        markerId: MarkerId('current_city'),
        draggable: false,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(double.parse(currentCity[1].replaceAll(',', '.')), double.parse(currentCity[2].replaceAll(',', '.'))),
      )
    );
    markers.add(
      Marker(
        markerId: MarkerId('current_pos'),
        draggable: false,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(47.571675, 19.095225),
        
      )
    );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _compas = 0;
  SimpleFlutterCompass _simpleFlutterCompass = SimpleFlutterCompass();
  //final _toRadians = 3.1416 / 180;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    currentPlayer = 0;
    addMarkers();
    _simpleFlutterCompass.listen().then((v) {
                    //listen request
    });
  }



  Future<void> initPlatformState() async {
    currentLocation = await location.getLocation();
    _simpleFlutterCompass.check().then((result) {
      if (result) {
        _simpleFlutterCompass.setListener(_streamListener);
      } else {
        print("Hardware not available");
      }
    });
     if (!mounted) return;
    }

   

    void _streamListener(double currentHeading) {
      if (!mounted) return;
      setState(() {
      //we set the new heading value to our _compas variable to display on screen
      _compas = currentHeading;
    });
  }

  
  /*_displayResultDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Here is your results:'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ADD PLAYER', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  
                  Navigator.of(context).pop();
                },
              )
            ],
          );
    });
  }*/

  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/
  Widget displayCityData()
  {
    if(countries)
    {
      return Column(
        children: <Widget>[          
          Text("${currentCity[0]}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),maxLines: 2,),          
          Text("${currentCity[3]}", style: TextStyle(fontSize: 15),),
        ],
      );      
    }else{
      return Text("${currentCity[0]}", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),maxLines: 2,);
    }
  }

  Widget displayDeviceHeading()
  {
     if(heading)
     {   
      if(_compas.ceil()*-1<22.5 || _compas.ceil()*-1>337.5)
      {
        return Text("Current heading: North", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1<67.5 && _compas.ceil()*-1>22.5){
        return Text("Current heading: North-East", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1>67.5 && _compas.ceil()*-1<112.5){
        return Text("Current heading: East", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1>112.5 && _compas.ceil()*-1<157.5){
        return Text("Current heading: South-East", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1<202.5 && _compas.ceil()*-1>157.5){
        return Text("Current heading: South", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1>202.5 && _compas.ceil()*-1<247.5){
        return Text("Current heading: South-West", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1<292.5 && _compas.ceil()*-1>247.5){
        return Text("Current heading: West", style: TextStyle(height: 2.3));
      }else if(_compas.ceil()*-1>292.5 && _compas.ceil()*-1<337.5){
        return Text("Current heading: North-West", style: TextStyle(height: 2.3));
      }       
     }
     return Container(height: 0, width: 0,); 
  }

  _displayDialog(){
    Completer<GoogleMapController> _controller = Completer();

    bearingDiff = (max(bearingTMP, _compas.ceil()*-1)-min(bearingTMP,_compas.ceil()*-1)).floor();

    
    if(bearingDiff<20){
      resultTitle="Wow you are very close! You just nearly missed by $bearingDiff degrees";
    }else if(bearingDiff<50){
      resultTitle="Not bad! You only missed by $bearingDiff degrees";
    }else if(bearingDiff>50){
      resultTitle="You can do better! You missed by $bearingDiff degrees";
    }
    //if(){}

    Alert(
        context: context,
        style: alertStyle,
        title: resultTitle,
        content: Column(
          children: <Widget>[            
            Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: GoogleMap(
                //mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(currentCity[1].replaceAll(',', '.')), double.parse(currentCity[2].replaceAll(',', '.'))),
                    zoom: 10.00,
                ),
                markers: Set.from(markers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },                
              ),
            ),      
            /*OutlineButton(
              child: Text("Maps!"),
              onPressed: ()
              {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => MapSample()),
                      );
              }
            ),*/
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () {
                if (!mounted) return;
                setState(() {
                  if(currentPlayer+1==players.length)
                  { 
                    currentPlayer = 0;
                    if(players.length!=1) round++;
                    if(roundQuestion || 1!=players.length) currentCity = worldcities[generateRandomNum(worldcities.length)].split(";");
                  }else{
                    currentPlayer+=1;
                  }
                });
                if(!roundQuestion || 1==players.length)
                {
                  currentCity = worldcities[generateRandomNum(worldcities.length)].split(";");
                }
                addMarkers();   
                Navigator.of(context).pop();
            },
            child: Text(
              "OKAY",
              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Segoe'),
            ),
          )
        ]).show();
  }

  //Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'History',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => History()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Settings()),
                );
              },
            ),
          ]),
          body: Center(
            child: Column(
              
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('${players[currentPlayer]}\'s turn\n',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ), //SZOROZZ BE MINUSSZAL MERT A _compas NEGATÍV ÉRTÉKET AD VISSZA
                //Text('Current Heading : ${_compas.ceil()*-1}\n'), //SZOROZZ BE MINUSSZAL MERT A _compas NEGATÍV ÉRTÉKET AD VISSZA
                    ButtonTheme(                                        
                        minWidth: MediaQuery.of(context).size.width * 0.8,//MediaQuery.of(context).,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: OutlineButton(
                            child: displayCityData(),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(0.0),
                              side: BorderSide(color: Colors.black)
                            ),
                            onPressed: () async {
                              //print("lat:${currentLocation.latitude} long:${currentLocation.longitude}");
                              if (!mounted) return;
                              setState(() {
                                bearingTMP = bearing(currentLocation.latitude* d_pi/ 180, currentLocation.longitude* d_pi/ 180, double.parse(currentCity[1].replaceAll(',', '.'))* d_pi/ 180, double.parse(currentCity[2].replaceAll(',', '.'))* d_pi/ 180);
                              });
                              history.add(players[currentPlayer]);
                              historyRoundMissedBy.add((max(bearingTMP, _compas.ceil()*-1)-min(bearingTMP,_compas.ceil()*-1)).floor());
                              historyRound.add(round);
                              //subT.add("Missed by: $bearingTMP");
                              
                              _displayDialog();
                            },
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 5,

                            ),
                            splashColor: Colors.transparent,  
                            highlightColor: Colors.transparent,
                            highlightedBorderColor: Colors.black54,
                          ),
                      ),                  
                //Text('bearing: $bearingTMP\n'),
                displayDeviceHeading(),
              ],
            ),
          ),
        );
  }
}