import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_colors.dart';

class CustomIconImage extends StatelessWidget {
  final String? image;
  final double? size;
  final double? spreadRadius;
  final double? borderRadius;
  final double? elevation;
  final Widget? icon;
  final VoidCallback onPress;
  final Color? backgroundColor;
  final double? imageSize;
  final double? padding;
  final Color? imgColor;

  const CustomIconImage({
    super.key,
    this.image,
    required this.onPress,
    this.size,
    this.icon,
    this.elevation,
    this.backgroundColor,
    this.spreadRadius,
    this.borderRadius, this.imageSize, this.padding, this.imgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Material(
        borderRadius: BorderRadius.circular(48),
        elevation: elevation ?? 3,
        child: Container(
          width: size ?? 40,
          height: size ?? 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
                width: 1,
                color: Theme.of(context).iconTheme.color!.withOpacity(.2)),
            shape: BoxShape.circle,
            
            boxShadow: [
              BoxShadow(
                color: AppColors.white.withOpacity(.1),
                spreadRadius: spreadRadius ?? 2,
                blurRadius: borderRadius ?? 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding:EdgeInsets.all(padding??.0),
            child: icon ?? Image.asset(image!,height: imageSize,width: imageSize,color: imgColor,),
          ),
        ),
      ),
    );
  }
}
