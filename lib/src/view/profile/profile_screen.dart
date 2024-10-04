// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/address/address_controller.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/order/order_controller.dart';
import 'package:paropkar/src/controller/profile/profile_controller.dart';
import 'package:paropkar/src/custom_widgets/custom_network_image.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/address/manage_address_screen.dart';
import 'package:paropkar/src/view/auth/change_password/forgot_pass_mobile_screen.dart';
import 'package:paropkar/src/view/favorite/favorite_listing_screen.dart';
import 'package:paropkar/src/view/invoice/invoice_screen.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/order/order_list_screen.dart';
import 'package:paropkar/src/view/profile/edit_profile_screen.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:provider/provider.dart';

// Colors for the theme
const primaryColor =
    Color(0xFF00A55B); // Example primary color (adjust as per design)
const greyColor = Color(0xFF757575); // Example grey color for text
const whiteColor = Color(0xFFFFFFFF); // Example white background

// Main Cart Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomController = Provider.of<BottomBarListController>(context);
    final profileController = Provider.of<ProfileController>(context);
    final orderController = Provider.of<OrderController>(context);
    final addressController = context.read<AddressController>();
    if (profileController.userData == null) {
      profileController.getUser(context);
    }
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
              bottomController.changeIndex(0);
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
          'My Profile',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: ListView(
          children: [
            Consumer<ProfileController>(builder: (context, controller, child) {
              if (kDebugMode) {
                print(controller.userData?.data?.image);
              }
              return Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: Row(
                  children: [
                    Container(
                      height: screenWidth * .16,
                      width: screenWidth * .16,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        shape: BoxShape.circle,
                      ),
                      child: CustomNetworkImage(
                        imageUrl: controller.userData?.data?.image ?? '',
                        errorWidget: const SizedBox(
                          child: Center(
                            child: Icon(Icons.person,
                                size: 50, color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userData?.data?.name ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(),
                        ),
                        Text(
                          controller.userData?.data?.mobile ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            largeHeight,
            Column(
              children: [
                ListTileProfileSction(
                  ontap: () {
                    AppNavigation.navigationPush(context, EditProfileScreen());
                  },
                  image: AppAssets.editProfile,
                  title: 'Edit profile',
                  padding: 8,
                ),
                ListTileProfileSction(
                    ontap: () {
                      AppNavigation.navigationPush(
                          context, ForgotPasswordScreen());
                    },
                    image: AppAssets.changePassword,
                    title: 'Change password',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {
                      addressController.getAddressApi(context);
                      AppNavigation.navigationPush(
                          context, ManageAddressScreen());
                    },
                    image: AppAssets.location,
                    title: 'My address',
                    padding: 5),
                ListTileProfileSction(
                    ontap: () {
                      AppNavigation.navigationPush(context, InvoiceScreen());
                    },
                    image: AppAssets.appInfo,
                    title: 'App information',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {},
                    image: AppAssets.language,
                    title: 'Language',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {
                      orderController.getOrderList(context);
                      AppNavigation.navigationPush(context, OrderListScreen());
                    },
                    imgColor: AppColors.white,
                    image: AppAssets.orders,
                    title: 'My Orders',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {
                      context.read<FavoriteController>().getFavorites();
                      AppNavigation.navigationPush(
                          context, const FavoriteListingScreen());
                    },
                    imgColor: AppColors.white,
                    image: AppAssets.favorite,
                    title: 'Favorite Items',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () async {
                      await showModalBottomSheet<void>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Consumer<ProfileController>(
                                builder: (context, controller, child) {
                              return LogoutWidget(
                                ontapLogout: () async {
                                  // context.read<BottomBarListController>().changeIndex(0);
                                  await profileController.logoutEvent(context);
                                },
                                isLoading: controller.logoutStatus ==
                                    DataStatus.loading,
                              );
                            });
                          });
                    },
                    image: AppAssets.logout,
                    title: 'Logout',
                    padding: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileProfileSction extends StatelessWidget {
  const ListTileProfileSction({
    super.key,
    required this.ontap,
    required this.image,
    required this.title,
    required this.padding,
    this.imgColor,
  });
  final VoidCallback ontap;
  final String image;
  final String title;
  final double padding;
  final Color? imgColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 12, right: 20, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIconImage(
              padding: padding,
              onPress: ontap,
              image: image,
              imgColor: imgColor,
              backgroundColor: AppColors.primaryColor,
            ),
            smallWidth,
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(child: smallHeight),
            InkWell(
              onTap: () {
                pop(context);
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
