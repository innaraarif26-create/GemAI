import 'package:flutter/material.dart';
import 'package:gemai/features/personalization/controllers/user_controller.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_strings.dart';
import '../../image_widget/circular_image.dart';

class AppUserProfileTile extends StatelessWidget {
  const AppUserProfileTile({
    super.key,
    required this.onPressed,
  });

final VoidCallback onPressed;
  @override
  Widget build(BuildContext context)
  {
    final controller = UserController.instance;
    return ListTile(
      leading: AppCircularImage(image: AppImages.user, width: 50, height: 50, padding: 0,),
      title: Text(controller.user.value.fullName,style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColors.white)),
      subtitle: Text(controller.user.value.email,style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: AppColors.white,),),
    );
  }
}
