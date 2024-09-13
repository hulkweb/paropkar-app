import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_screen.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_image_icon.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';

// Colors for the theme
const primaryColor =
    Color(0xFF00A55B); // Example primary color (adjust as per design)
const greyColor = Color(0xFF757575); // Example grey color for text
const whiteColor = Color(0xFFFFFFFF); // Example white background

// Main Cart Screen
class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cartController = CartController();
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
              padding: const EdgeInsets.only(left: 10),
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
          'Cart',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
          child: Column(
            children: [
              Column(
                  children: List.generate(
                      cartController.cartItemList.length,
                      (index) => CartItem(
                            title: cartController.cartItemList[index].title,
                            subTitle:
                                cartController.cartItemList[index].subTitle,
                            price: cartController.cartItemList[index].price,
                            unit: cartController.cartItemList[index].title,
                            quantity:
                                cartController.cartItemList[index].quantity,
                          ))),
              const SizedBox(height: 10),
              Container(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: CustomTextFormWidget(
                          controller: cartController.couponTextController,
                          contentpadding: const EdgeInsets.only(left: 20),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          fillColor: AppColors.primaryColor.withOpacity(.1),
                          hintText: "Enter code",
                          validator: (String? value) {
                            return null;
                          },
                          suffixWidget: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              text: 'Apply',
                              height: 40,
                              width: 70,
                              borderRadius: 39,
                              ontap: () {
                                cartController.ontapApplyCoupon(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sub Total',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('₹ ${cartController.subtotal}',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Charges',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('₹ ${cartController.deiiveryCages}',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('- ₹ ${cartController.discount}',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Price',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text('₹ ${cartController.total}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: screenWidth * .3,
        child: CheckoutButton(
          total: 850.00,
          // onPressed: () {},
          onPressed: () {
            cartController.ontapContinueButton(context);
          },
          text: 'Continue',
        ),
      ),
    );
  }
}

// Custom Cart Item Widget
class CartItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final double price;
  final String unit;
  final int quantity;

  const CartItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.unit,
    required this.quantity,
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
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppFonts.regular),
                    maxLines: 3,
                  ),
                ),
                Text(
                  '₹ $price',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryColor,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 17,
                      fontFamily: AppFonts.semiBold),
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconImage(
                    elevation: 1,
                    spreadRadius: 0,
                    borderRadius: 3,
                    size: 27,
                    backgroundColor: AppColors.grey,
                    icon: const Icon(
                      Icons.remove,
                      size: 19,
                      color: AppColors.primaryColor,
                    ),
                    onPress: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      '1KG',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.primaryColor,
                          overflow: TextOverflow.ellipsis,
                          fontFamily: AppFonts.semiBold,
                          fontSize: 15),
                    ),
                  ),
                  CustomIconImage(
                    spreadRadius: 0,
                    borderRadius: 0,
                    size: 27,
                    backgroundColor: AppColors.primaryColor,
                    icon: Icon(
                      Icons.add,
                      size: 19,
                      color: Theme.of(context).cardColor,
                    ),
                    onPress: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Checkout Button Widget
class CheckoutButton extends StatelessWidget {
  final double total;
  final String text;
  final VoidCallback onPressed;

  const CheckoutButton(
      {super.key,
      required this.total,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius (increase size of shadow)
            blurRadius: 7, // Blur radius (smooth the edges of shadow)
            offset: Offset(0, 3), // Position of shadow (x,y)
          ),
        ],
      ),

      // height: screenHeight * .1,
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.primaryColor)),
              SizedBox(
                width: screenWidth * .34,
                child: Text('₹ $total',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontFamily: AppFonts.semiBold,
                        overflow: TextOverflow.ellipsis)),
              ),
            ],
          ),
          CustomButton(
            width: screenWidth * .5,
            text: text,
            ontap: onPressed,
          )
        ],
      ),
    );
  }
}
