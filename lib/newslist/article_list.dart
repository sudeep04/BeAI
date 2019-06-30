import 'package:flutter/material.dart';
import 'package:be_ai/newslist/modal/article.dart';
import 'package:be_ai/newslist/article_list_item.dart';

class NewsList extends StatelessWidget {
  final List<News> _newsList;

  NewsList(this._newsList);

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
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          
          return Card( //                           <-- Card widget
            child: NewsCard(
                news: _newsList[index], 
                item: _newsList[index]
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