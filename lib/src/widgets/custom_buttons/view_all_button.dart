import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_colors.dart';

// Custom Button Widget
class ViewAllButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback onPressed;

   const ViewAllButton({
    super.key,
     this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
      buttonText??  'View All',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}
