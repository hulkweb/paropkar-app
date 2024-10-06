import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/address/address_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/product/product_detail_model.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/address/create_address_screen_.dart';
import 'package:paropkar/src/custom_widgets/cards/address_card_simple.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({super.key});

  // final  addressController = AddressController();

  @override
  Widget build(BuildContext context) {
    final addressController = context.read<AddressController>();
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
          'Manage Address',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<AddressController>(
                builder: (context, addressController, child) {
              print(addressController.removeAddressStatus);
              print(
                addressController.addressDataStatus,
              );
              bool isDataEmpty = addressController.addressListData == null ||
                  addressController.addressListData.data == null ||
                  addressController.addressListData.data!.isEmpty;
              return SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: DataStateWidget(
                  status: addressController.addressDataStatus,
                  emptyDataWidget: Center(
                    child: SizedBox(
                      height: screenHeight * .1,
                      width: screenWidth * .5,
                      child: Center(
                        child: TextButton(
                          child: Text(
                            'Add New Address',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onPressed: () {
                            addressController.clearAllControllers();
                            AppNavigation.navigationPush(context,
                                CreateAddressScreen(screenType: 'create'));
                          },
                        ),
                      ),
                    ),
                  ),
                  ontapRetry: () {
                    addressController.getAddressApi(context);
                  },
                  isOverlay: (addressController.removeAddressStatus ==
                          OverlayStatus.loading)
                      ? true
                      : false,
                  isDataEmpty: isDataEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, right: 12, bottom: 20),
                    child: Column(
                        children: isDataEmpty
                            ? []
                            : List.generate(
                                addressController.addressListData.data!.length +
                                    1, (index) {
                                if (addressController
                                        .addressListData.data!.length ==
                                    index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: CustomButton(
                                      width: screenWidth * .5,
                                      buttonText: 'Add New Address',
                                      ontap: () {
                                        addressController.clearAllControllers();
                                        AppNavigation.navigationPush(
                                            context,
                                            CreateAddressScreen(
                                                screenType: 'create'));
                                      },
                                    ),
                                  );
                                }
                                final address = addressController
                                    .addressListData.data![index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: AddressCardSimple(
                                    ontapEdit: () {
                                      addressController.clearAllControllers();
                                      addressController.assignAddressValue(
                                          name: address.name ?? '',
                                          phoneNumber: address.phone ?? '',
                                          pinCode: address.postalCode ?? '',
                                          state: address.state ?? '',
                                          city: address.city ?? '',
                                          addressMain: address.address ?? '',
                                          addressLandmark:
                                              address.address ?? '',
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
                                    onTap: () {
                                      addressController.defaultAddressApi(
                                          context,
                                          addressId: address.id.toString());
                                    },
                                    address: (address.address ?? '') +
                                        ', ' +
                                        (address.postalCode ?? ""),
                                    addressType: address.type ?? '',
                                    ontapDelete: () {
                                      addressController.removeAddressApi(
                                          context,
                                          addressId: address.id.toString());
                                    },
                                    isDefault:
                                        address.isDefault.toString() == '1'
                                            ? true
                                            : false,
                                    phone: address.phone ?? '',
                                  ),
                                );
                              })),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
