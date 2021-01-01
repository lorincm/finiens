import 'package:flutter/material.dart';
import "globals.dart";


class Settings extends StatefulWidget{
  @override
  SettingsState createState() => SettingsState();
}



class SettingsState extends State<Settings>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                title: Text("Display country names",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                activeColor: Colors.black,
                value: countries,
                onChanged: (bool value){
                  setState((){
                    countries = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text("Display current device heading",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                activeColor: Colors.black,
                value: heading,
                onChanged: (bool value1){
                  setState((){
                    heading = value1;
                  });
                },
              ),
              SwitchListTile(
                title: Text("Same objectives throughout rounds",
                  style: TextStyle(fontWeight: FontWeight.bold),),
                activeColor: Colors.black,
                value: roundQuestion,
                onChanged: (bool value2){
                  setState((){
                    roundQuestion = value2;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

}