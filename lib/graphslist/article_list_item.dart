import 'package:flutter/material.dart';
import 'package:be_ai/graphslist/modal/article.dart';
import 'package:intl/intl.dart';

class GraphCard extends StatelessWidget {
  const GraphCard(
      {Key key,
      this.graph,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Graph graph;
  final VoidCallback onTap;
  final Graph item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
        color: Colors.white,
        child: InkWell(
            onTap: () async {
              // GraphCard selectedCard = context.widget as GraphCard;
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DisplayGraphArticle(
              //             data: selectedCard.item,
              //           ),
              //     ));
              // if (await canLaunch(selectedCard.news.articleLink)) {
              //   await launch(selectedCard.news.articleLink);
              // } else {
              //   throw 'Could not launch $selectedCard.news.articleLink';
              // }
              //print((ChoiceCard)context.widget
            },
            
            child: Column(
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(graph.imglink)),
                new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(graph.title,
                          style: Theme.of(context).textTheme.title),
                      //Text(choice.date, style: TextStyle(color: Colors.black.withOpacity(0.5))),
                      //Text(choice.description),
                      // new Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       //new Text(news.author, style: TextStyle(color: Colors.blue)),
                      //       //new Text(choice.date, style: TextStyle(color: Colors.blue))  new DateFormat('yyyy-MM-dd h:m:s').format(DateTime.parse("2018-09-15 20:18:04Z")),
                      //       new Text(
                      //           new DateFormat('MM-dd-yy h:m')
                      //               .format(DateTime.parse(news.date)),
                      //           style: TextStyle(color: Colors.blue))
                      //     ]),
                      // Text(news.description,
                      //     style:
                      //         TextStyle(color: Colors.black.withOpacity(0.5))),
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}
