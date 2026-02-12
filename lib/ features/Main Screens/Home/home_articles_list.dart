import 'package:flutter/cupertino.dart';

import '../../../core/constants/sizes.dart';
import '../../../widgets/Articles_Widget/articles_container.dart';

class AppArticlesList extends StatelessWidget {
  const AppArticlesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.articlesHeight,
      child:  ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (_, index) {
            return AppHomeArticles();
          }
      ),
    );
  }
}