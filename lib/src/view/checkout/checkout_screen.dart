import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/checkout/checkout_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/address/create_address_screen_.dart';
import 'package:paropkar/src/view/address/manage_address_screen.dart';
import 'package:paropkar/src/view/cart/cart_screen%20new.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/checkout/checkout_widgets.dart';
import 'package:paropkar/src/custom_widgets/cards/address_card_selective.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/view_all_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:provider/provider.dart';

import 'package:paropkar/src/utills/globle_func.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final checkoutController = CheckoutController();
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
              onPress: () {},
            ),
          ),
        ],
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * .01,
                    right: screenWidth * .01,
                    top: 10,
                    bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Address',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ViewAllButton(
                      onPressed: () {
                        AppNavigation.navigationPush(
                            context,const CreateAddressScreen());
                      },
                      buttonText: 'Add new',
                    )
                  ],
                ),
              ),
              Consumer<CheckoutController>(
                  builder: (context, checkoutController, child) {
                return Column(
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: AddressCardSelective(
                              onTap: () {
                                checkoutController.setAddress(index);
                              },
                              addressType:
                                  checkoutController.addressList[index].type ??
                                      '',
                              address: checkoutController
                                      .addressList[index].address ??
                                  '',
                              isSelected:
                                  checkoutController.getAddressIndex() == index,
                            ),
                          )),
                );
              }),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * .01,
                    right: screenWidth * .01,
                    top: 10,
                    bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Add new',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              Consumer<CheckoutController>(
                  builder: (context, checkoutController, child) {
                return PaymentCard(
                  isSelected: checkoutController.getPaymentType() == 'cod',
                  image: AppAssets.cod,
                  title: 'Cash on delivery',
                  setPaymentStaus: () {
                    checkoutController.setPayment('cod');
                  },
                );
              }),
              Consumer<CheckoutController>(
                  builder: (context, checkoutController, child) {
                return PaymentCard(
                  isSelected: checkoutController.getPaymentType() == 'online',
                  image: AppAssets.atmCard,
                  title: 'Pay Onlinne',
                  setPaymentStaus: () {
                    checkoutController.setPayment('online');
                  },
                );
              }),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: screenWidth * .3,
        child: CheckoutButton(
          total: 850.00,
          onPressed: () {
            checkoutController.ontapContinue(context);
          },
          text: 'Continue',
        ),
      ),
    );
  }
}
