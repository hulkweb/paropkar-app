// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/address/address_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/custom_status_bar.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:provider/provider.dart';

class CreateAddressScreen extends StatelessWidget {
  CreateAddressScreen({super.key, required this.screenType, this.address_id});
  final String screenType;
  final String? address_id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addressController = Provider.of<AddressController>(context);
    const contentpadding = EdgeInsets.only(top: 18, bottom: 18, left: 10);
    return StatusBarCustom(
      statusBarBrightnessLight: true,
      statusBarColor: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
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
            actions: const [
              // Padding(
              //   padding: const EdgeInsets.only(right: 20),
              //   child: CustomIconImage(
              //     backgroundColor: AppColors.primaryColor.withOpacity(.7),
              //     icon: Icon(
              //       Icons.notifications_outlined,
              //       color: Theme.of(context).cardColor,
              //       size: 23,
              //     ),
              //     onPress: () {},
              //   ),
              // ),
            ],
            title: Text(
              screenType == 'edit' ? 'Edit Address' : "Create Address",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontFamily: AppFonts.semiBold,
                  color: Theme.of(context).canvasColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth,
                  ),
                  // Toggle Buttons
                  largeHeight,
                  CustomTextFormWidget(
                    contentpadding: contentpadding,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: addressController.nameController,
                    hintText: "Full Name*",
                    validator: (value) {
                      return addressController.nameValidation(value,
                          emptyText: 'Enter Full Name');
                    },
                  ),
                  mediumHeight,
                  CustomTextFormWidget(
                    contentpadding: contentpadding,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    fillColor: AppColors.white,
                    controller: addressController.mobileFieldController,
                    hintText: "Phone Number*",
                    validator: (value) {
                      return addressController.mobileValidation(value);
                    },
                  ),
                  mediumHeight,
                  SizedBox(
                    width: screenWidth * .9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextFormWidget(
                          contentpadding: contentpadding,
                          width: screenWidth * .5,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          fillColor: AppColors.white,
                          controller: addressController.pincodeController,
                          hintText: "Pincode*",
                          validator: (value) {
                            return addressController.pincodeValidation(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  mediumHeight,
                  SizedBox(
                    width: screenWidth * .9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextFormWidget(
                          contentpadding: contentpadding,
                          width: screenWidth * .44,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          fillColor: AppColors.white,
                          controller: addressController.stateController,
                          hintText: "State*",
                          validator: (value) {
                            return addressController.nameValidation(value,
                                emptyText: "Enter State");
                          },
                        ),
                        Expanded(child: smallWidth),
                        CustomTextFormWidget(
                          contentpadding: contentpadding,
                          width: screenWidth * .44,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          fillColor: AppColors.white,
                          controller: addressController.cityController,
                          hintText: "City*",
                          validator: (value) {
                            return addressController.nameValidation(value,
                                emptyText: "Enter City");
                          },
                        ),
                      ],
                    ),
                  ),
                  mediumHeight,
                  CustomTextFormWidget(
                    contentpadding: contentpadding,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: addressController.localAddressController,
                    hintText:
                        "House Number, Building Name, Road Name, Area, Colony*",
                    validator: (value) {
                      return addressController.nameValidation(value,
                          emptyText: 'Enter Required Information');
                    },
                  ),
                  // largeHeight,
                  // CustomTextFormWidget(
                  //   contentpadding: contentpadding,
                  //   // isDense: true,
                  //   maxLength: 50,
                  //   keyboardType: TextInputType.name,
                  //   fillColor: AppColors.white,
                  //   controller: addressController.landMarkController,
                  //   hintText: "Road Name, Area, Colony*",
                  //   validator: (value) {
                  //     return addressController.nameValidation(value,
                  //         emptyText: 'Enter Required Information');
                  //   },
                  // ),
                  largeHeight,
                  SizedBox(
                    width: screenWidth * .9,
                    child: Row(
                      children: [
                        Expanded(
                          child: RadioListTile<AddressType>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Home'),
                            value: AddressType.home,
                            fillColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                            groupValue: addressController.selectedAddressType,
                            onChanged: (AddressType? value) {
                              if (value != null) {
                                addressController.setAddressType(value);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<AddressType>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Office'),
                            fillColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                            value: AddressType.office,
                            groupValue: addressController.selectedAddressType,
                            onChanged: (AddressType? value) {
                              if (value != null) {
                                addressController.setAddressType(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  largeHeight,
                  Consumer<AddressController>(
                      builder: (context, controller, child) {
                    return CustomButton(
                      isLoading: controller.addressAddUpdateStatus ==
                              ButtonStatus.loading
                          ? true
                          : false,
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.ontapSaveAddress(context, address_id);
                        }
                      },
                      buttonText: 'Save Address',
                    );
                  }),
                  mediumHeight
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
