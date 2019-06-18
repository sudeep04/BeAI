import 'package:be_ai/articlelist/modal/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:share/share.dart';

class DisplayArticle extends StatelessWidget {
  final Choice data;

  DisplayArticle({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BeAI Article"),
          actions: <Widget>[
            new FlatButton(
                child: 
                new Icon(Icons.share, color: Colors.white,),
                // new Text('Share',
                //     style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => Share.share('Found this interesting article and thought you would like it. Take a look and I would love to hear your thoughts on it.\n${this.data.articleLink} \n-Sent from Be AI Business App' ) )
          ],
      ),
    body: new Center(
        child: SingleChildScrollView(
          child: Html(
            data: "<h1>"+ this.data.title +"</h1><br />"+
            this.data.content,
            //Optional parameters:
            padding: EdgeInsets.all(8.0),
            customRender: (node, children) {
          if (node is dom.Element) {
            if (node.localName == 'video') {

                }
          }
            }
          ),
        ),
      ),
    );
  }
}