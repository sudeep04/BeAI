import 'package:be_ai/articlelist/article_list_item.dart';
import 'package:flutter/material.dart';
import 'package:be_ai/services/authentication.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:be_ai/articlelist/article_list.dart';
import 'package:be_ai/articlelist/modal/article.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    _checkEmailVerification();
    getJSONData();
  }



  final String url = "https://warrenenskat.com/wp-json/wp/v2/posts";
  List data;

  // Function to get the JSON data
  void getJSONData() async{
    var response =  await get(
        // Encode the url
        Uri.encodeFull(url),
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    // Logs the response body to the console
    print(response.body);

    // To modify the state of the app, use this method
    setState(() {
      // Get the JSON data
      var dataConvertedToJSON = json.decode(response.body);
      // Extract the required part and assign it to the global variable named data
      data = dataConvertedToJSON;
    });

    //return "Successfull";
  }


 List<Choice> choices = new List<Choice>();
  void _buildArticles()
  {
   
     for(var i = 0;i<data.length;i++){

      String title =  data[i]['title']['rendered'].toString();
      String imgLink =  data[i]['featured_image_link'].toString();
      String date =  data[i]['modified_gmt'].toString();
      String author = data[i]['author'].toString() == '4'?"Warren Enskat": data[i]['author'].toString();
      String content = data[i]['content']['rendered'].toString();
      String articleLink = data[i]['link'].toString();
      
      choices.add(new Choice( title: title, date : date,  description:  '', imglink:imgLink,author: author,content: content,articleLink: articleLink));
    }
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail(){
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  Widget _showArticles() {
     
    //getJSONData();
    if(data!= null)
    {
    _buildArticles();
    }
      // return Center(child: Text("Welcome. The following are the articles",
      //   textAlign: TextAlign.start,
      //   style: TextStyle(fontSize: 20.0),));
    return new Scaffold(body: new ChoiceList(choices));
    
  }

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('BeAI App'),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: _signOut)
          ],
        ),
        body: _showArticles(),
    );
  }
}
