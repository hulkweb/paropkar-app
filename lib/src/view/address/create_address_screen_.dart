import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/address/create_address_controller.dart';
import 'package:paropkar/src/controller/auth_controller/signup_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/custom_status_bar.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:provider/provider.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final createAddressController = CreateAddressController();

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<CreateAddressController>(context);
    final contentpadding = EdgeInsets.only(top: 18, bottom: 18, left: 10);
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
            actions: [
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
              'Create Address',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 20,
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
                   contentpadding:contentpadding,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: createAddressController.nameController,
                    hintText: "Full Name*",
                    validator: (value) {
                      return createAddressController.nameValidation(value,
                          emptyText: 'Enter Full Name');
                    },
                  ),
                  mediumHeight,
                  CustomTextFormWidget(
                    contentpadding:contentpadding,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: createAddressController.mobileFieldController,
                    hintText: "Phone Number*",
                    validator: (value) {
                      return createAddressController.mobileValidation(value);
                    },
                  ),
                  mediumHeight,
                  SizedBox(
                    width: screenWidth * .9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextFormWidget(
                          contentpadding:contentpadding,
                          width: screenWidth * .5,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          fillColor: AppColors.white,
                          controller: createAddressController.pincodeController,
                          hintText: "Pincode*",
                          validator: (value) {
                            return createAddressController
                                .pincodeValidation(value);
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
                          contentpadding:contentpadding,
                          width: screenWidth * .44,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          fillColor: AppColors.white,
                          controller: createAddressController.stateController,
                          hintText: "State*",
                          validator: (value) {
                            return createAddressController.nameValidation(value,
                                emptyText: "Enter State");
                          },
                        ),
                        Expanded(child: smallWidth),
                        CustomTextFormWidget(
                          contentpadding:contentpadding,
                          width: screenWidth * .44,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          fillColor: AppColors.white,
                          controller: createAddressController.cityController,
                          hintText: "City*",
                          validator: (value) {
                            return createAddressController.nameValidation(value,
                                emptyText: "Enter City");
                          },
                        ),
                      ],
                    ),
                  ),
                  mediumHeight,
                  CustomTextFormWidget(
                    contentpadding:contentpadding,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: createAddressController.localAddressController,
                    hintText: "House Number, Building Name*",
                    validator: (value) {
                      return createAddressController.nameValidation(value,
                          emptyText: 'Enter Required Information');
                    },
                  ),
                  largeHeight,
                  CustomTextFormWidget(
                     contentpadding:contentpadding,
                    // isDense: true,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: createAddressController.landMarkController,
                    hintText: "Road Name, Area, Colony*",
                    validator: (value) {
                      return createAddressController.nameValidation(value,
                          emptyText: 'Enter Required Information');
                    },
                  ),
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
                            fillColor:
                                MaterialStateProperty.all(AppColors.primaryColor),
                            groupValue: addressProvider.selectedAddressType,
                            onChanged: (AddressType? value) {
                              if (value != null) {
                                addressProvider.setAddressType(value);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<AddressType>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Office'),
                            fillColor:
                                MaterialStateProperty.all(AppColors.primaryColor),
                            value: AddressType.office,
                            groupValue: addressProvider.selectedAddressType,
                            onChanged: (AddressType? value) {
                              if (value != null) {
                                addressProvider.setAddressType(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  largeHeight,
                  CustomButton(
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        createAddressController.ontapSaveAddress(context);
                      }
                    },
                    text: 'Save Address',
                  ),
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
