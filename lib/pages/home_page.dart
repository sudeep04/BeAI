import 'package:be_ai/articlelist/article_list_item.dart';
import 'package:be_ai/pages/MenuPages/AmAI.dart' as prefix1;
import 'package:be_ai/pages/MenuPages/Bookmarks.dart' as prefix4;
import 'package:be_ai/pages/MenuPages/DataVault.dart' as prefix3;
import 'package:be_ai/pages/MenuPages/GeneralAI.dart' as prefix2;
import 'package:be_ai/pages/MenuPages/Home.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:be_ai/services/authentication.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:be_ai/articlelist/article_list.dart';
import 'package:be_ai/articlelist/modal/article.dart';
import 'page.dart';
import 'myDrawer.dart';
import 'package:be_ai/pages/MenuPages/AMAI.dart';
import 'package:be_ai/pages/MenuPages/bookmarks.dart';
import 'package:be_ai/pages/MenuPages/ci.dart';
import 'package:be_ai/pages/MenuPages/datavault.dart';
import 'package:be_ai/pages/MenuPages/generalai.dart';
import 'package:be_ai/pages/MenuPages/home.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut, this.userEmail})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final String userEmail;

  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Asset Management AI", Icons.collections),
    new DrawerItem("General AI", Icons.language),
    new DrawerItem("Data Vault", Icons.trending_up),
    new DrawerItem("Bookmarks", Icons.bookmark),
    new DrawerItem("Competitive Intelligence", Icons.people)
  ];

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isEmailVerified = false;

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new prefix0.HomeFragment();
      case 1:
        return new prefix1.AmAI();
      case 2:
        return new prefix2.GeneralAI();
      case 3:
        return new prefix3.DataVault();
      case 4:
        return new prefix4.Bookmarks();
      case 5:
        return new CIPage();

      default:
        return new prefix0.HomeFragment();
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

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
  List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }
    
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
              drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text(""), 
                accountEmail: new Text(widget.userEmail),
                currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage("https://demo.plantobuild.de/Content/icon-user.png"),
                ),
                onTap: () { print("This is your current account.");
                  //Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("User Settings")));
                }
              ), 
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage("https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                  fit: BoxFit.fill
                )
              ),
            ),   
            new Column(children: drawerOptions)
          ],
        ),
      ),
        body: _getDrawerItemWidget(_selectedDrawerIndex), //_showArticles()
    );
  }
}
