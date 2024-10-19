import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/order/order_controller.dart';
import 'package:paropkar/src/controller/order/order_detail_controller.dart';
import 'package:paropkar/src/custom_widgets/custom_network_image.dart';
import 'package:paropkar/src/custom_widgets/data_state_widget.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';
import 'package:provider/provider.dart';

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
    final orderController = Provider.of<OrderController>(context);
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
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).cardColor,
                size: 23,
              ),
            ),
            onPress: () {
              pop(context);
            },
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
              onPress: () {
                AppNavigation.navigationPush(context, NotificationScreen());
              },
            ),
          ),
        ],
        title: Text(
          'My Order',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Column(
          children: [
            Expanded(
              child: Consumer<OrderController>(
                  builder: (context, controller, child) {
                bool isDataEmpty = orderController.orders == null ||
                    orderController.orders!.data == null ||
                    orderController.orders!.data!.isEmpty;
                return DataStateWidget(
                  status: controller.ordersDataStatus,
                  ontapRetry: () {
                    controller.getOrderList(context);
                  },
                  isDataEmpty: isDataEmpty,
                  child: isDataEmpty
                      ? const SizedBox()
                      : ListView(
                          children: List.generate(
                              orderController.orders!.data!.length, (index) {
                          final order = orderController.orders!.data![index];
                          return OrderItem(
                            image: order.orderItems?[0].product?.image ?? '',
                            orderId: '#${order.id ?? 1}',
                            title: order.orderItems?[0].product?.name ?? '',
                            starCount: 6,
                            timing: formatDate(order.createdAt.toString()),
                            quantity: 1,
                            status: order.status ?? '',
                            onTap: () {
                              AppNavigation.navigationPush(
                                  context,
                                  OrderDetailScreen(
                                    orderId: order.id.toString(),
                                  ));
                            },
                          );
                        })),
                );
              }),
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
  final String orderId;
  final String timing;
  final double starCount;
  final int quantity;
  final String status;
  final VoidCallback onTap;
  final String image;

  const OrderItem({
    super.key,
    required this.title,
    required this.orderId,
    required this.timing,
    required this.starCount,
    required this.quantity,
    required this.status,
    required this.onTap,
    required this.image,
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
              child: CustomNetworkImage(
                imageUrl: image,
              ),
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
                  child: Text(orderId,
                      style: Theme.of(context).textTheme.titleLarge!),
                ),
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.primaryColor,
                        overflow: TextOverflow.ellipsis,
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          overflow: TextOverflow.ellipsis,
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
