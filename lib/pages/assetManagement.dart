import 'package:flutter/material.dart';
import 'myDrawer.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First screen"),
                  actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: () {} )
          ],
        ),
      
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          "First Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}