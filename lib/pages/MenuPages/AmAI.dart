import 'package:be_ai/articlelist/article_list.dart';
import 'package:be_ai/articlelist/modal/article.dart';
import 'package:be_ai/newslist/article_list.dart';
import 'package:be_ai/newslist/modal/article.dart';
import 'package:be_ai/newslist/modal/article.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// class AmAI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return new Center(
//       child: new Text("Asset Management AI"),
//     );
//   }

// }
class AmAI extends StatefulWidget {
  @override
  State createState() => new AmAIState();
}

class AmAIState extends State<AmAI> {
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
        .child("/articlesByCategory/9001")
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
        title: Text('AM AI'),
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
        .child("/articlesByCategory/9001")
        .once()
        .then((DataSnapshot snapshot) {
      data = snapshot.value;
    });

//database referene.
    // var recentJobsRef = FirebaseDatabase.instance
    //     .reference()
    //     .child('/articlesByCategory/9001')
    //     //.orderByChild('datePublished') //order by creation time.
    //     .limitToFirst(10); //limited to get only 10 documents.

//Now you can use stream builder to get the data.
//     StreamBuilder(
//       stream: recentJobsRef.onValue,
//       builder: (context, snap) {
//         if (snap.hasData &&
//             !snap.hasError &&
//             snap.data.snapshot.value != null) {
//           //taking the data snapshot.
//           DataSnapshot snapshot = snap.data.snapshot;
//           List item = [];
//           List _list = [];
// //it gives all the documents in this list.
//           _list = snapshot.value;
// //Now we're just checking if document is not null then add it to another list called "item".
// //I faced this problem it works fine without null check until you remove a document and then your stream reads data including the removed one with a null value(if you have some better approach let me know).
//           _list.forEach((f) {
//             if (f != null) {
//               item.add(f);
//             }
//           });
//           return snap.data.snapshot.value == null
//               ? SizedBox()
//               : _list;
// //return sizedbox if there's nothing in database.

// //otherwise return a list of widgets.

//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
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
