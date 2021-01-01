import 'package:flutter/material.dart';
//import 'package:sailor/sailor.dart';
import "startscreen.dart";
import 'package:flutter/services.dart';
import "globals.dart";// as globals;
import "game.dart";// as globals;
import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';


void main() async
{
  
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  WidgetsFlutterBinding.ensureInitialized();
  round = 1;
  a = await getFileData();
  worldcities = a.split("\n");
  currentCity = worldcities[generateRandomNum(worldcities.length)].split(";");
  print(currentCity);
  print(worldcities.length);
  print(worldcities[1]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
    
    runApp(
      
      new App());
  });
} 

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SwipeDeleteDemo(),
        title: "finiens",
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(            
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 3.0, color: Colors.black)
            )
          )
        )
    );
  }
}