import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'game.dart';
import "globals.dart";
import 'package:rflutter_alert/rflutter_alert.dart';


class SwipeDeleteDemo extends StatefulWidget {
  SwipeDeleteDemo() : super();
  @override
  SwipeDeleteDemoState createState() => SwipeDeleteDemoState();
}

class SwipeDeleteDemoState extends State<SwipeDeleteDemo> {
  TextEditingController _textFieldController = TextEditingController();

  /*_displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            //title: Text('TextField in Dialog'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Type here"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('ADD PLAYER', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  if(_textFieldController.text!=''){
                    setState(() {
                    players.add(_textFieldController.text);
                    });
                    _textFieldController.text = '';
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
    });
  }*/
  _displayDialog(){
     Alert(
        context: context,
        style: alertStyle,
        title: "",
        content: Column(
          children: <Widget>[
            TextField(
              //obscureText: true,
              textAlign: TextAlign.center,
              controller: _textFieldController,
              decoration: InputDecoration(

                //icon: Icon(Icons.lock),
                //labelText: 'player name',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () {
              if(_textFieldController.text!=''){
                setState(() {
                  players.add(_textFieldController.text);
                });
                _textFieldController.text = '';
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "ADD PLAYER",
              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Segoe'),
            ),
          )
        ]).show();
  }

  @override
  void initState() {
    super.initState();

    players = List();
  }

  removePlayer(index) {
    setState(() {
      players.removeAt(index);
    });
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
    );
  }

  Widget list() {
    return ListView.builder(
      padding: EdgeInsets.all(20.0),

      itemCount: players.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
      },
    );
  }

  Widget row(context, index) {
    return Dismissible(
      key: Key(players[index]), // UniqueKey().toString()
      onDismissed: (direction) {
        removePlayer(index);
      },
      background: refreshBg(),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
        ),
        child: ListTile(
          title: Text(players[index]),
          
        ),
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    //globalContext = context;
  
    return Scaffold(
        body:new Column(
        children: <Widget>[
          new Text("\n"),
          new Text("\n"),
          new Text('finiens', style: TextStyle(fontFamily: 'SegoeBold', fontSize: 50.0, fontWeight: FontWeight.w400, )),
          new Expanded(
            child: list()
          )
        ], ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 75.0,
                height: 75.0,
                  child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () {
                    _displayDialog(); 
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.black,
                ),
              ),
              SizedBox(
              width: 75.0,
              height: 75.0,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    if (players.length == 0) {
                      Flushbar(
                        margin: EdgeInsets.all(8),
                        borderRadius: 8,
                        //title: ,
                        //message: 
                        flushbarPosition: FlushbarPosition.TOP,
                        flushbarStyle: FlushbarStyle.FLOATING,
                        titleText: Text("You need at least one player", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Segoe'),),
                        messageText: Text("Tap the add button to add a player", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Segoe'),),
                        duration: Duration(seconds: 3),
                        isDismissible: false,
                        backgroundColor: Colors.black,
                      )..show(context);
                    } else {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => returnMyApp()),
                        MaterialPageRoute(builder: () { return MyHome() };
                      );*/
                      //Navigator.pushNamed(context, '/second');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => MyApp()),
                      );
                    }
                  },
                  child: Icon(Icons.navigate_next),
                  backgroundColor: Colors.black,
                  shape: new BeveledRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0)
                  ),
                  
                ),
              )
            ],
          ),
        )
      );
  }
}
