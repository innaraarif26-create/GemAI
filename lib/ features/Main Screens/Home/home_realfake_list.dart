import 'package:flutter/cupertino.dart';
import '../../../widgets/RealFake_Widget/realfake_container.dart';

class AppRealFakeList extends StatelessWidget {
  const AppRealFakeList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (_, index) {
          return AppHomeRealFakeList();
        },
      ),
    );
  }
}
