import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/address/address_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/checkout/checkout_controller.dart';
import 'package:paropkar/src/controller/order/order_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
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
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:provider/provider.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:paropkar/src/utills/globle_func.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.total});
  final String total;
  @override
  Widget build(BuildContext context) {
    final addressController = context.read<AddressController>();
    final checkoutController = context.read<CheckoutController>();
    final orderController = context.read<OrderController>();
    addressController.getAddressApi(context);
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
                        context.read<AddressController>().clearAllControllers();
                        AppNavigation.navigationPush(
                            context,
                            CreateAddressScreen(
                              screenType: 'create',
                            ));
                      },
                      buttonText: 'Add new',
                    )
                  ],
                ),
              ),
              Consumer<AddressController>(
                  builder: (context, addressController, child) {
                bool isDataEmpty = addressController.addressListData == null ||
                    addressController.addressListData!.data == null ||
                    addressController.addressListData!.data!.isEmpty;
                return DataStateWidget(
                  emptyDataWidget: SizedBox(),
                  status: addressController.addressDataStatus,
                  ontapRetry: () {
                    addressController.getAddressApi(context);
                  },
                  isDataEmpty: isDataEmpty,
                  child: Column(
                    children: isDataEmpty
                        ? []
                        : List.generate(
                            addressController.addressListData.data!.length,
                            (index) {
                            final address =
                                addressController.addressListData.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: AddressCardSelective(
                                onTap: () {
                                  addressController
                                      .setAddressId(address.id.toString());
                                },
                                addressType: address.type ?? '',
                                address: (address.address ?? '') +
                                    ', ' +
                                    (address.postalCode ?? ""),
                                isSelected: address.id.toString() ==
                                    addressController.selectedAddressId,
                                onEdit: () {
                                  addressController.clearAllControllers();
                                  addressController.assignAddressValue(
                                      name: address.name ?? '',
                                      phoneNumber: address.phone ?? '',
                                      pinCode: address.postalCode ?? '',
                                      state: address.state ?? '',
                                      city: address.city ?? '',
                                      addressMain: address.address ?? '',
                                      addressLandmark: address.address ?? '',
                                      addressType: address.type == 'home'
                                          ? AddressType.home
                                          : AddressType.office);
                                  AppNavigation.navigationPush(
                                      context,
                                      CreateAddressScreen(
                                        screenType: 'edit',
                                        address_id: address.id.toString(),
                                      ));
                                },
                                phone: address.phone ?? '',
                              ),
                            );
                          }),
                  ),
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
                    // Text(
                    //   'Add new',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .titleLarge!
                    //       .copyWith(color: Theme.of(context).primaryColor),
                    // ),
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
                  title: 'Pay Online',
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
          total: total,
          onPressed: () async {
            String addressId = addressController.selectedAddressId;
            String paymentType = checkoutController.getPaymentType();
            if (paymentType == 'online') {
              return;
            }
            if (addressId.isEmpty || addressId == 'null') {
              if (kDebugMode) {
                showToast(
                    message: 'Please select one address',
                    gravity: ToastGravity.BOTTOM);
                return;
              }
            }
            var token = await getToken();
            var headers = {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            };
            orderController.placeOrder(context,
                addressId: '24',
                paymentType: 'cod',
                paymentStatus: 'unpaid');
            // ignore: use_build_context_synchronously
            // await orderController.placeOrder(
            //   context,
            //   addressId: addressId,
            //   paymentType: paymentType,
            //   paymentStatus: 'unpaid',
            // );
            // checkoutController.ontapContinue(context);
          },
          text: 'Continue',
        ),
      ),
    );
  }
}
