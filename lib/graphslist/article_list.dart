import 'package:flutter/material.dart';
import 'package:be_ai/graphslist/modal/article.dart';
import 'package:be_ai/graphslist/article_list_item.dart';

class GraphsList extends StatelessWidget {
  final List<Graph> _graphsList;

  GraphsList(this._graphsList);

  @override
  Widget build(BuildContext context) {
    // return new ListView(
    //         shrinkWrap: true,
    //         padding: const EdgeInsets.all(20.0),
    //         children: 
    //         List.generate(_choiceList.length,(index) {
    //             return Center(
    //               child: ChoiceCard(choice: _choiceList[index], item: _choiceList[index]),
    //             );
    //         })
    // );

  return new ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
        itemCount: _graphsList.length,
        itemBuilder: (context, index) {
          
          return Card( //                           <-- Card widget
            child: GraphCard(
                graph: _graphsList[index], 
                item: _graphsList[index]
            ),
          );
        }
  );

  // List<ArticleListItem> _buildArticlesList() {
  //   return _articleModal
  //       .map((article) => new ArticleListItem(article))
  //       .toList();
  // }
}
}