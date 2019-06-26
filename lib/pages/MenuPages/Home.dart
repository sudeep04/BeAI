import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:be_ai/articlelist/modal/article.dart';
import 'package:be_ai/articlelist/article_list.dart';

final String url = "https://warrenenskat.com/wp-json/wp/v2/posts";
List data;
List<Choice> choices = new List<Choice>();

class HomeFragment extends StatelessWidget {

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
    //setState(() {
      // Get the JSON data
      var dataConvertedToJSON = json.decode(response.body);
      // Extract the required part and assign it to the global variable named data
      data = dataConvertedToJSON;
    }
    



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

  Widget _showArticles() {
     
    getJSONData();
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
    
     return new Center(
       child: _showArticles(),
     );
    //_showArticles();
  }

}