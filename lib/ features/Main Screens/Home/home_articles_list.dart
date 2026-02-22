import 'package:flutter/cupertino.dart';
import '../../../core/constants/image_strings.dart';
import '../../../core/constants/sizes.dart';
import '../../../widgets/Articles_Widget/articles_container.dart';

class AppArticlesList extends StatelessWidget {
  const AppArticlesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final articlesImages = [
      {"image": AppImages.article1, "title": "How to tell if a diamond is real."},
      {"image": AppImages.article2, "title": "Educate kids about rock collection."},
      {"image": AppImages.article3, "title": "Tips for gemstone investment."},
      {"image": AppImages.article4, "title": "Guide to buying gemstones"},
    ];
    return SizedBox(
      height: AppSizes.articlesHeight,

      child:  ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: articlesImages.length,
          itemBuilder: (_, index) {
            return AppHomeArticles(
               backgroundColor: Color.fromARGB(255, 239, 239, 239),
              image: articlesImages[index]["image"]!,
              title: articlesImages[index]["title"]!,
              onTap: (){},
            );
          }
      ),
    );
  }
}