import 'package:flutter/material.dart';
import 'package:be_ai/articlelist/modal/article.dart';
import 'package:be_ai/pages/displayarticle.dart';
import 'package:intl/intl.dart';


class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key, this.choice, this.onTap, @required this.item, this.selected: false}
    ) : super(key: key);
 
  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
        return Card(
          color: Colors.white,
          child: InkWell(onTap: () {
            ChoiceCard selectedCard = context.widget as ChoiceCard;
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DisplayArticle(
                     data: selectedCard.item,
                  ),
                  ));
                  
            //print((ChoiceCard)context.widget
          }, 
                   //child: Text("hello")));
          child: 
          Column(
              children: <Widget>[
                new Container( 
                  padding: const EdgeInsets.all(8.0),
                  child: 
                  Image.network(
                    choice.imglink
                  )),
                  new Container( 
                  padding: const EdgeInsets.all(10.0),
                  child:                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(choice.title, style: Theme.of(context).textTheme.title),
                        //Text(choice.date, style: TextStyle(color: Colors.black.withOpacity(0.5))),
                        //Text(choice.description),
                        new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Text(choice.author, style: TextStyle(color: Colors.blue)),
                        //new Text(choice.date, style: TextStyle(color: Colors.blue))  new DateFormat('yyyy-MM-dd h:m:s').format(DateTime.parse("2018-09-15 20:18:04Z")),
                        new Text(new DateFormat('MM-dd-yy h:m').format(DateTime.parse(choice.date)), style: TextStyle(color: Colors.blue))
                      ]
                    )
                      ],
                    ),
                    
                  )
            ],
           crossAxisAlignment: CrossAxisAlignment.start,
          )
    ));
  }
}