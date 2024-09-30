import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    this.height,
    this.width,
    this.textAppTextStyles,
    this.borderRadius,
    required this.text,
    this.border,
    this.ontap,
    this.isLowerCase,
    this.isLoading,
    this.isArrowButton,
    this.loading,
  });
  final Color? color;
  final double? height;
  final double? width;
  final TextStyle? textAppTextStyles;
  final double? borderRadius;
  final String text;
  final BoxBorder? border;
  final void Function()? ontap;
  final bool? isLowerCase;
  final bool? isLoading;
  final Widget? loading;
  final bool? isArrowButton;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? screenWidth * .8,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            overlayColor:
                MaterialStatePropertyAll(AppColors.black.withOpacity(.1)),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 30),
              ),
            )),
        onPressed: isArrowButton ?? false ? null : ontap,
        child: Center(
            child: isLoading ?? false
                ? loading ??
                    const SizedBox(
                      width: 48,
                      height: 48,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      ),
                    )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isArrowButton ?? false
                          ? const SizedBox(
                              width: 48,
                            )
                          : SizedBox(),
                      SizedBox(
                        width: width ?? screenWidth * .8,
                        child: Text(
                          isLowerCase != null ? text : text,
                          style: textAppTextStyles ?? AppTextStyles.normalWhite,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      isArrowButton ?? false
                          ? Container(
                              width: 48,
                              child: ElevatedButton(
                                onPressed: ontap,
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(8),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.primaryColor),
                                ),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(48),
                                    onTap: ontap,
                                    child: const Center(
                                        child: Icon(
                                      Icons.arrow_forward,
                                      size: 28,
                                      color: AppColors.white,
                                    ))),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  )),
      ),
    );
  }
}
