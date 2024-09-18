import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/src/controller/address/manage_address_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/address/create_address_screen_.dart';
import 'package:paropkar/src/custom_widgets/cards/address_card_simple.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:provider/provider.dart';

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({super.key});

  // final  addressController = AddressController();

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
          'Edit Address',
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
              Consumer<ManageAddressController>(
                  builder: (context, addressController, child) {
                return Column(
                  children: List.generate(
                      addressController.addressList.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: AddressCardSimple(
                              ontapEdit: () {
                                AppNavigation.navigationPush(context, CreateAddressScreen());
                              },
                              onTap: () {
                                addressController.setAddress(index);
                              },
                              addressType:
                                  addressController.addressList[index].type ??
                                      '',
                              address: addressController
                                      .addressList[index].address ??
                                  '',
                            ),
                          )),
                );
              }),
              const SizedBox(height: 32),
              mediumHeight,
              // Submit Button
              CustomButton(
                text: 'Save',
                ontap: () {},
              ),
              mediumHeight,
              mediumHeight
            ],
          ),
        ),
      ),
    );
  }
}
