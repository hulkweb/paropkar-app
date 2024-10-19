import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/order/order_detail_controller.dart';
import 'package:paropkar/src/custom_widgets/custom_network_image.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/home/home_screen.dart';
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
class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen(
      {super.key, required this.orderId, this.screenRedirect});
  final String orderId;
  final String? screenRedirect;
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoginWithOtp = false;
  @override
  Widget build(BuildContext context) {
    final orderDetailController = context.read<OrderDetailController>();
    final bottomController = Provider.of<BottomBarListController>(context);
    context.read<OrderDetailController>().orderDetail(widget.orderId);
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
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).cardColor,
                size: 23,
              ),
            ),
            onPress: () {
              if (widget.screenRedirect != null && (widget.screenRedirect == 'placeOrder')) {
                  bottomController.changeIndex(0);
                AppNavigation.navigationReplacement(
                    context, const BottomBarListScreen());
              } else {
                 Navigator.pop(context);
              }
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Consumer<OrderDetailController>(
          builder: (context, orderDetailController, child) {
        return SingleChildScrollView(
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
                      spreadRadius:
                          5, // Spread radius (increase size of shadow)
                      blurRadius: 7, // Blur radius (smooth the edges of shadow)
                      offset: const Offset(0, 3), // Position of shadow (x,y)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order number',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                '#${widget.orderId}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Login With OTP button
                              GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   isLoginWithOtp = true;
                                  // });
                                  orderDetailController
                                      .ontapCustomerButton(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: isLoginWithOtp
                                        ? Colors.green
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Text(
                                    'customer',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: isLoginWithOtp
                                              ? Colors.white
                                              : Colors.green,
                                        ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 10), // space between buttons

                              // Login With Password button
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: !isLoginWithOtp
                                        ? Colors.green
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Text(
                                    'track order',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: !isLoginWithOtp
                                              ? Colors.white
                                              : Colors.green,
                                        ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 13, bottom: 0),
                      child: Theme(
                        data: ThemeData().copyWith(
                            shadowColor: AppColors.white,
                            dividerColor: Colors.transparent,
                            // dividerColor: Colors.white,
                            cardColor: Colors.white),
                        child: ExpansionTile(
                          initiallyExpanded: true,
                          leading: Text(
                            'Products',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          title: const Text(''), // Remove divider lines
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.zero,
                          backgroundColor: Colors.white, // No background color
                          collapsedBackgroundColor: Colors.white,
                          children: List.generate(
                              orderDetailController.orderDetailData?.data
                                      ?.orderItems?.length ??
                                  0, (index) {
                            final orderItem = orderDetailController
                                .orderDetailData?.data?.orderItems![index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: OrderItem(
                                productName: orderDetailController
                                        .orderDetailData!
                                        .data!
                                        .orderItems?[index]
                                        .product
                                        ?.name ??
                                    '',
                                productType: 'cat',
                                price: orderItem?.product?.price ?? '',
                                quantity: orderItem?.quantity,
                                status: '',
                                onTap: () {
                                  // AppNavigation.navigation(
                                  //   context,
                                  // );
                                },
                                image: orderItem?.product?.image ?? '',
                                isNetworkImage: true,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 13, right: 13, top: 20),
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Order Note:',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyMedium!
                    //               .copyWith(
                    //                   fontFamily: AppFonts.semiBold,
                    //                   overflow: TextOverflow.ellipsis)),
                    //       SizedBox(
                    //         width: screenWidth * .04,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 5),
                    //         child: SizedBox(
                    //           width: screenWidth * .4,
                    //           child: Text(
                    //             'ship all ordered item together on friday. i’ve emailed please check.Thanks',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyMedium!
                    //                 .copyWith(
                    //                     fontFamily: AppFonts.light,
                    //                     overflow: TextOverflow.ellipsis),
                    //             maxLines: 10,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    smallHeight,
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: PriceSection(
                        /*    subTotal: orderDetailController.orderDetailData?.data?.totalAmount,
                          deliveryCharges: orderDetailController.orderDetailData?.data?.totalAmount,
                          discount:  orderDetailController.orderDetailData?.data?.totalAmount, */
                        subTotal: orderDetailController
                                .orderDetailData?.data?.totalAmount ??
                            '0.0',
                        deliveryCharges: '0',
                        discount: '0',
                        total: orderDetailController
                                .orderDetailData?.data?.totalAmount ??
                            '0.0',
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// Custom Cart Item Widget
class OrderItem extends StatelessWidget {
  final String? productName;
  final String? productType;
  final int? quantity;
  final String? status;
  final VoidCallback onTap;
  final String? price;
  final bool isNetworkImage;
  final String? image;

  const OrderItem({
    super.key,
    this.productName,
    this.productType,
    this.quantity,
    required this.status,
    required this.onTap,
    this.price,
    this.image,
    required this.isNetworkImage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
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
            height: screenWidth * .25,
            width: screenWidth * .25,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: isNetworkImage
                  ? CustomNetworkImage(
                      imageUrl: image ?? '',
                    )
                  : Image.asset(AppAssets.maida),
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
                  child: Text(
                    productName ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    productType ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontFamily: AppFonts.light),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    'Qty $quantity',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontFamily: AppFonts.light),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Text('₹ $price',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.semiBold,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

// Custom Checkout Section Widget
class PriceSection extends StatelessWidget {
  final String? subTotal;
  final String? deliveryCharges;
  final String? discount;
  final String? total;

  const PriceSection({
    super.key,
    required this.subTotal,
    required this.deliveryCharges,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: whiteColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.primaryColor)),
              Text('₹ $subTotal',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Charges',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                      )),
              Text('₹ $deliveryCharges',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.red,
                      )),
              Text('- ₹ $discount',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Final Price',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                      )),
              Text('₹ $total', style: Theme.of(context).textTheme.bodyMedium!),
            ],
          ),
        ],
      ),
    );
  }
}
