import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';

enum DataStatus { loading, error, success }

bool isDataLoading(DataStatus status) {
  return status == DataStatus.loading;
}

bool isDataError(DataStatus status) {
  return status == DataStatus.error;
}

bool isDataFetched(DataStatus status) {
  return status == DataStatus.success;
}

class DataStateWidget extends StatelessWidget {
  final DataStatus status;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget child; //success screen
  final double? loadingHeight;
  final double? loadingWidth;
  final double? errorHeight;
  final double? errorWidth;
  final VoidCallback ontapRetry;
  final bool isDataEmpty;
  final Widget? emptyDataWidget;

  const DataStateWidget({
    super.key,
    required this.status,
    required this.child,
    this.loadingWidget,
    this.errorWidget,
    this.loadingHeight,
    this.loadingWidth,
    this.errorHeight,
    this.errorWidth,
    required this.ontapRetry,
    required this.isDataEmpty,
    this.emptyDataWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case DataStatus.loading:
        return Center(
          child: SizedBox(
            height: loadingHeight ?? 40,
            width: loadingWidth ?? 40,
            child: InkWell(
                onTap: ontapRetry,
                child: loadingWidget ??
                    const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )),
          ),
        );
      case DataStatus.error:
        return Center(
          child: Center(
            child: errorWidget ??
                CustomButton(
                  text: "Retry",
                  ontap: ontapRetry,
                  width: errorWidth ?? screenWidth * .5,
                ),
          ),
        );
      case DataStatus.success:
        // ignore: prefer_const_constructors
        return isDataEmpty
            ? emptyDataWidget ??
                Center(
                    child: Image.asset(
                  AppAssets.emptyData,
                  height: screenWidth * .3,
                  width: screenWidth * .3,
                ))
            : child; // Required success widget
    }
  }
}
