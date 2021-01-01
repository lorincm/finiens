import 'package:flutter/material.dart';
import 'globals.dart';

const String testDevice = 'Mobile_id';

class History extends StatefulWidget {
  History() : super();
  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends State<History> {

  

  removeHistory() {
    setState(() {
      history.removeWhere((item) => item != null);
      historyRoundMissedBy.removeWhere((item) => item != null);
      historyRound.removeWhere((item) => item != null);
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
      itemCount: history.length,
      itemBuilder: (BuildContext context, int index) {
        return row(context, index);
      },
    );
  }

  Widget row(context, index) {
      return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: ListTile(
          //leading: Icon(), //Icons.graphic_eq, Icons.blur_on, Icons.donut_large
          title: Text(history[index]),
          subtitle: Text("Round: ${historyRound[index]}, missed by: ${historyRoundMissedBy[index]}"),
        ),
      );
  }
 

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: AppBar(
        title: Text("History", style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              iconSize: 30.0,
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Clear',
              onPressed: () {
                removeHistory();
              },
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: list()
          )
        ]
      )
    );
  }
}

