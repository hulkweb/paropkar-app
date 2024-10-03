import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/order/order_detail_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/order/customer_detail_screen.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:provider/provider.dart';

// Colors for the theme
const primaryColor =
    Color(0xFF00A55B); // Example primary color (adjust as per design)
const greyColor = Color(0xFF757575); // Example grey color for text
const whiteColor = Color(0xFFFFFFFF); // Example white background

// Main Cart Screen
class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  bool isLoginWithOtp = false;
  @override
  Widget build(BuildContext context) {
    final orderDetailController = context.read<OrderDetailController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          'Order Details',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth * 1,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 12, right: 8, bottom: 20),
            child: Container(
              // padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
              margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius (increase size of shadow)
                    blurRadius: 7, // Blur radius (smooth the edges of shadow)
                    offset: const Offset(0, 3), // Position of shadow (x,y)
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * .05,
                        right: screenWidth * .05,
                        top: screenWidth * .05),
                    child: Builder(builder: (context) {
                      final customer =
                          orderDetailController.orderDetailData?.data?.user;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer Information',
                              style: Theme.of(context).textTheme.headline6),
                          const SizedBox(height: 16.0),
                          _buildDetailItem('Name', customer?.name),
                          _buildDetailItem('Mobile', customer?.mobile),
                          _buildDetailItem('Email', customer?.email),
                          _buildDetailItem('Area', customer?.address),
                          // _buildDetailItem('City', customer?.),
                          // _buildDetailItem('Landmark', 'Ratnagiri'),
                          // _buildDetailItem('Pincode', '452349'),
                          // _buildDetailItem('Payment', 'Online'),
                          _buildDetailItem('Status', customer?.status),
                          // ... add other customer details here
                        ],
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, top: 12, right: 8, bottom: 20),
                    child: Container(
                      // padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                      margin:
                          const EdgeInsets.only(left: 12, top: 12, right: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1), // Shadow color
                            spreadRadius:
                                2, // Spread radius (increase size of shadow)
                            blurRadius:
                                2, // Blur radius (smooth the edges of shadow)
                            offset:
                                const Offset(0, 1), // Position of shadow (x,y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              mediumHeight,
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Text('Activity',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                            ],
                          ),
                          OrderStatusSection(
                            isSuccess: (orderDetailController.orderSatus ==
                                    'readyToPickup') ||
                                (orderDetailController.orderSatus ==
                                    'orderProcessed') ||
                                (orderDetailController.orderSatus ==
                                    'paymentConfirm') ||
                                (orderDetailController.orderSatus ==
                                    'orderPlaced'),
                            title: 'Ready to Pickup',
                            subtitle: 'Order #135426 from Hing Powder',
                            date: '12 sep',
                            isLast: false,
                          ),
                          OrderStatusSection(
                            isSuccess: (orderDetailController.orderSatus ==
                                    'orderProcessed') ||
                                (orderDetailController.orderSatus ==
                                    'paymentConfirm') ||
                                (orderDetailController.orderSatus ==
                                    'orderPlaced'),
                            title: 'Order Processed',
                            subtitle: 'Order #135426 from Hing Powder',
                            date: '12 sep',
                            isLast: false,
                          ),
                          OrderStatusSection(
                            isSuccess: (orderDetailController.orderSatus ==
                                    'paymentConfirm') ||
                                (orderDetailController.orderSatus ==
                                    'orderPlaced'),
                            title: 'Payment Confirm',
                            subtitle: 'Order #135426 from Hing Powder',
                            date: '12 sep',
                            isLast: false,
                          ),
                          OrderStatusSection(
                            isSuccess: (orderDetailController.orderSatus ==
                                'orderPlaced'),
                            title: 'Order Placed',
                            subtitle: 'Order #135426 from Hing Powder',
                            date: '12 sep',
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(width: 16.0),
          Text(
            value ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontFamily: AppFonts.light, fontSize: 13),
          )
        ],
      ),
    );
  }
}

class OrderStatusSection extends StatelessWidget {
  const OrderStatusSection(
      {super.key,
      required this.isSuccess,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.isLast});
  final bool isSuccess;
  final String title;
  final String subtitle;
  final String date;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * .02,
        right: screenWidth * .02,
      ),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: screenWidth * .07,
                    width: screenWidth * .07,
                    decoration: BoxDecoration(
                        color:
                            isSuccess ? AppColors.primaryColor : AppColors.grey,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.check,
                      size: isSuccess ? null : 18,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  isLast
                      ? SizedBox()
                      : Container(
                          height: 40,
                          width: 2,
                          color: isSuccess
                              ? AppColors.primaryColor
                              : AppColors.grey,
                        )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 13)),
                  Text(subtitle,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
              Text(date,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryColor,
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPersonInfo() {
    // Implement your delivery person information here
    return Row(
      children: [
        // Image of delivery person
        // Delivery person name
      ],
    );
  }
}

class OrderStatusProgressLinear extends StatelessWidget {
  const OrderStatusProgressLinear({
    super.key,
    required this.isSuccess,
  });
  final bool isSuccess;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          width: screenWidth * .4,
          child: LinearProgressIndicator(
            value: 1,
            color: isSuccess ? AppColors.primaryColor : AppColors.grey,
          )),
    );
  }
}
