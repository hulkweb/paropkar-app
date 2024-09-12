import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';
import 'package:paropkar/src/widgets/custom_image_icon.dart';

// Colors for the theme
const primaryColor =
    Color(0xFF00A55B); // Example primary color (adjust as per design)
const greyColor = Color(0xFF757575); // Example grey color for text
const whiteColor = Color(0xFFFFFFFF); // Example white background

// Main Cart Screen
class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: CustomIconImage(
            backgroundColor: AppColors.primaryColor.withOpacity(.7),
            size: 20,
            icon: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).cardColor,
                size: 23,
              ),
            ),
            onPress: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomIconImage(
              backgroundColor: AppColors.primaryColor.withOpacity(.7),
              icon: Icon(
                Icons.notifications_outlined,
                color: Theme.of(context).cardColor,
                size: 23,
              ),
              onPress: () {},
            ),
          ),
        ],
        title: Text(
          'My Order',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                  children: List.generate(
                      15,
                      (index) => OrderItem(
                            title: '#13256420',
                            subTitle: 'Masala',
                            starCount: 4,
                            timing: 'Arriving Soon ',
                            quantity: 1,
                            status: '',
                            onTap: () {
                              AppNavigation.navigation(
                                  context, OrderDetailScreen());
                            },
                          ))),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Cart Item Widget
class OrderItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String timing;
  final double starCount;
  final int quantity;
  final String status;
  final VoidCallback onTap;

  const OrderItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.timing,
    required this.starCount,
    required this.quantity,
    required this.status,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: screenWidth * .2,
            width: screenWidth * .2,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(AppAssets.maida),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ////////////
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(title,
                      style: Theme.of(context).textTheme.bodyLarge!),
                ),
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontFamily: AppFonts.regular),
                    maxLines: 3,
                  ),
                ),
                Row(
                  children: List.generate(
                      5,
                      (index) => Icon(
                            Icons.star,
                            size: 15,
                            color: starCount <= index
                                ? AppColors.grey
                                : AppColors.primaryColor,
                          )),
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status == 'success'
                            ? AppColors.primaryColor
                            : AppColors.errorColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$timing',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          fontFamily: AppFonts.light),
                    ),
                  ],
                )
              ],
            ),
          ),
          CustomIconImage(
            elevation: 1,
            spreadRadius: 0,
            borderRadius: 3,
            size: 35,
            backgroundColor: AppColors.primaryColor,
            icon: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 19,
                color: Theme.of(context).cardColor,
              ),
            ),
            onPress: onTap,
          ),
        ],
      ),
    );
  }
}
