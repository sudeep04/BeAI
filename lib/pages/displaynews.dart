import 'package:be_ai/newslist/modal/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayNewsArticle extends StatefulWidget {
  @override
  State createState() => new DisplayNewsArticleState();
  final News data;
  DisplayNewsArticle({this.data});
}

class DisplayNewsArticleState extends State<DisplayNewsArticle> {
  final _key = UniqueKey();

  @override
  Response response;
  void initState() {
    //initiate(widget.data.articleLink);
  }

  Future initiate(String url) async {
    var client = Client();
    response = await client.get(url);

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BeAI Article"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.thumb_down),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.share),
              onPressed: () {
                Share.share(
                    'Found this interesting article and thought you would like it. Take a look and I would love to hear your thoughts on it.\n${this.widget.data.articleLink} \n-Sent from Be AI Business App');
              },
            ),
          ],
        ),
        body: //new Center(
            // child: SingleChildScrollView(
            //   child: Html(

            //       data: this.response.body,
            //           //"<h1>" + this.widget.data.title + "</h1><br />" + this.widget.data.content,
            //       //Optional parameters:
            //       padding: EdgeInsets.all(8.0),
            //       customRender: (node, children) {
            //         if (node is dom.Element) {
            //           if (node.localName == 'video') {}
            //         }
            //       }),
            // ),
            //Expanded(
            new Center(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: this.widget.data.articleLink)) //)
        // ),
        );
  }
}
