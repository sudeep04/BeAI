import 'package:flutter/material.dart';
import 'package:be_ai/newslist/article_list.dart';
import 'package:be_ai/newslist/modal/article.dart';
import 'package:firebase_database/firebase_database.dart';


class GeneralAI extends StatefulWidget {
  @override
  State createState() => new GeneralAIState();
}

class GeneralAIState extends State<GeneralAI> {
  dynamic data;

  @override
  void initState() {
    // This is the proper place to make the async calls
    // This way they only get called once

    // During development, if you change this code,
    // you will need to do a full restart instead of just a hot reload

    // You can't use async/await here,
    // We can't mark this method as async because of the @override
    databaseReference
        .child("/articlesByCategory/9998")
        .orderByChild('datePublished')
        .once()
        .then((DataSnapshot snapshot) {
      data = snapshot.value;
       setState(() {
        //
      });
    });
  }

  final databaseReference = FirebaseDatabase.instance.reference();

  List<News> newsList = new List<News>();
  @override
  Widget build(BuildContext context) {
    if (data == null) {
            // This is what we show while we're loading
           return Center(child: CircularProgressIndicator());
        }
        
    return Scaffold(
      appBar: AppBar(
        title: Text('General AI'),
      ),
      body: Center(child: _buildArticles()), //center
    );
  }

  void iterateMapEntry(key, value) {
    String title = value['title'].toString();
    String imgLink = value['imageUrl'].toString();
    String date = value['datePublished'] == null? "":value['datePublished'].toString();
    String author =
        ""; //data[i]['author'].toString() == '4'?"Warren Enskat": data[i]['author'].toString();
    String content = value['body'].toString();
    String articleLink = value['articleUrl'].toString();
    String desc = value['description'].toString();

    newsList.add(new News(
        title: title,
        date: date,
        description: desc,
        imglink: imgLink,
        author: author,
        content: content,
        articleLink: articleLink));
  }

  void getData() async {
    await databaseReference
        .child("/articlesByCategory/9998")
        .once()
        .then((DataSnapshot snapshot) {
      data = snapshot.value;
    });

  }


  Widget _buildArticles() {
    //getData();
    if (data != null) {
      data.forEach(iterateMapEntry);
    }
    return new Scaffold(body: new NewsList(newsList));
  }

  Widget _showArticles() {
    // getData();
    // if(data!= null)
    // {
    // _buildArticles();
    // }
    // return Center(child: Text("Welcome. The following are the articles",
    //   textAlign: TextAlign.start,
    //   style: TextStyle(fontSize: 20.0),));
   return new Scaffold(body: new NewsList(newsList));
  }

}
