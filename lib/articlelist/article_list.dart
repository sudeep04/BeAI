import 'package:flutter/material.dart';
import 'package:be_ai/articlelist/modal/article.dart';
import 'package:be_ai/articlelist/article_list_item.dart';

class ChoiceList extends StatelessWidget {
  final List<Choice> _choiceList;

  ChoiceList(this._choiceList);

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
        itemCount: _choiceList.length,
        itemBuilder: (context, index) {
          
          return Card( //                           <-- Card widget
            child: ChoiceCard(
                choice: _choiceList[index], 
                item: _choiceList[index]
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