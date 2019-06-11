import 'package:be_ai/articlelist/modal/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:html/dom.dart' as dom;


class DisplayArticle extends StatelessWidget {
  final Choice data;

  DisplayArticle({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BeAI Article"),
      ),
    body: new Center(
        child: SingleChildScrollView(
          child: Html(
            data: "<h>"+ this.data.title +"</h><br />"+
            this.data.content,
            //Optional parameters:
            padding: EdgeInsets.all(8.0),
            customRender: (node, children) {
          if (node is dom.Element) {
            if (node.localName == 'video') {
              FlutterYoutube.playYoutubeVideoById(
                  apiKey: "AIzaSyCFp_mQfG8O-ZmEf-tDTWojALJB7WeXzMM",
                  videoId: node.attributes['src'],
                  autoPlay: true,
                  fullScreen: true 
              );
                }
          }
            }
          ),
        ),
      ),
    );
  }
}