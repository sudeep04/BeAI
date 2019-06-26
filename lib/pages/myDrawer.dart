import 'package:be_ai/pages/assetManagement.dart';
import 'package:flutter/material.dart';
import 'page.dart';


class RootDrawer {
  static DrawerControllerState of(BuildContext context) {
    final DrawerControllerState drawerControllerState =
        context.rootAncestorStateOfType(TypeMatcher<DrawerControllerState>());
    return drawerControllerState;
  }
}

class RootScaffold {
  static openDrawer(BuildContext context) {
    final ScaffoldState scaffoldState =
        context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    scaffoldState.openDrawer();
  }

  static ScaffoldState of(BuildContext context) {
    final ScaffoldState scaffoldState =
        context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    return scaffoldState;
  }
}

class MyDrawer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;
  
  const MyDrawer({Key key, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
    return Drawer(
         child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text("widget.userEmail"),
              accountName: new Text(""),
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
            new ListTile(
              title: new Text("Home"),
              leading: new Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Page("Home")));
              }
            ),
            new ListTile(
              title: new Text("Asset Management AI"),
              leading: new Icon(Icons.collections),
              onTap: () {
                //Navigator.of(context).pop();
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstScreen()),
              );
                //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Asset Management AI")));
              }
            ),
            new ListTile(
              title: new Text("General AI"),
              leading: new Icon(Icons.language),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("General AI")));
              }
            ),
            new ListTile(
              title: new Text("Data Vault"),
              leading: new Icon(Icons.trending_up),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Data Vault")));
              }
            ),
            new ListTile(
              title: new Text("Bookmarks"),
              leading: new Icon(Icons.bookmark),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Bookmarks")));
              }
            ),
            new ListTile(
              title: new Text("Competitive Intelligence"),
              leading: new Icon(Icons.people),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Competitive Intelligence")));
              }
            ),
            new Divider(),
            new ListTile(
              title: new Text("Cancel"),
              leading: new Icon(Icons.cancel),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
    );
  }
}