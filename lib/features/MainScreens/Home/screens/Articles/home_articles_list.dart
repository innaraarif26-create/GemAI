import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../widgets/Articles_Widget/articles_container.dart';
import '../../../../../widgets/data/articles_data.dart';
import 'article_pdf_viewer.dart';

class AppArticlesList extends StatelessWidget
{
  const AppArticlesList({
    super.key, });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.articlesHeight,
      child:  ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: articles.length,
          itemBuilder: (_, index)
          {
            final article = articles[index];
            return AppHomeArticles(
              image: articles[index]["image"]!,
              title: articles[index]["title"]!,
              onTap: () => Get.to(()=> ArticlePDFViewer(title: article["title"]!,  pdfPath: article["pdf"]!,),),
            );
          }
      ),
    );
  }
}