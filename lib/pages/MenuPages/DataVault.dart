import 'package:be_ai/graphslist/article_list.dart';
import 'package:be_ai/graphslist/modal/article.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataVault extends StatefulWidget {
  @override
  State createState() => new DataVaultState();
}

class DataVaultState extends State<DataVault> {
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
        .child("/dataVault/aiIndex18")
        .once()
        .then((DataSnapshot snapshot) {
      data = snapshot.value;
       setState(() {
        //
      });
    });
  }

  final databaseReference = FirebaseDatabase.instance.reference();
  StorageReference storageReference = FirebaseStorage.instance.ref();

  List<Graph> graphList = new List<Graph>();
  @override
  Widget build(BuildContext context) {
    if (data == null) {
            // This is what we show while we're loading
           return Center(child: CircularProgressIndicator());
        }
        
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Vault'),
      ),
      body: Center(child: _buildArticles()), //center
    );
  }

  Future iterateMapEntry(key, value) async {
    String title = value['graphName'].toString();
    String imgLink = value['imgName'].toString();
    String imgUrl = "https://sudeeplocal.s3.amazonaws.com/aiIndex18/" + imgLink;
    //String imgUrl = await storageReference.child('/aiIndex18/'+imgLink).getDownloadURL();
    // String date = value['datePublished'] == null? "":value['datePublished'].toString();
    // String author =
    //     ""; //data[i]['author'].toString() == '4'?"Warren Enskat": data[i]['author'].toString();
    // String content = value['body'].toString();
    // String articleLink = value['articleUrl'].toString();
    // String desc = value['description'].toString();

    graphList.add(new Graph(
        title: title,
        imglink: imgUrl));
  }



  Widget _buildArticles() {
    //getData();
    if (data != null) {
      data.forEach(iterateMapEntry);
    }
    return new Scaffold(body: new GraphsList(graphList));
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
   return new Scaffold(body: new GraphsList(graphList));
  }

}
