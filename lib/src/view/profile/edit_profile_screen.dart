import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/profile/profile_edit_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/constant.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/custom_widgets/textfields/lable_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  // Function to show the popup to choose between camera and gallery
  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              mediumHeight
            ],
          ),
        );
      },
    );
  }

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  // Function to pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  final ProfileEditController profileEditController = ProfileEditController();
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
          'Edit Profile',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                largeHeight,
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: Container(
                        height: screenWidth * .16,
                        width: screenWidth * .16,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          shape: BoxShape.circle,
                        ),
                        child: _imageFile == null
                            ? Padding(
                                padding: EdgeInsets.all(
                                    _imageFile == null ? 12.0 : 0),
                                child: Image.asset(
                                  AppAssets.camera,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Image.file(_imageFile!, fit: BoxFit.cover),
                      ),
                    ),
                    mediumWidth,
                    GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context),
                        child: Text("Photo Upload +",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.primaryColor,
                                ))),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .05,
                ),
                // Name Field
                CustomFormRow(
                  keyboardType: TextInputType.name,
                  labelText: "Name",
                  controller: profileEditController.nameController,
                  focusNode: profileEditController.nameFocusNode,
                  hintText: "Enter your name",
                  isRequired: true,
                  validator: (value) {
                    return profileEditController.validateName(value!);
                  },
                ),
                const SizedBox(height: 16),
                // Last Name Field
                CustomFormRow(
                  keyboardType: TextInputType.name,
                  labelText: "Last Name",
                  controller: profileEditController.lastNameController,
                  focusNode: profileEditController.lastNameFocusNode,
                  hintText: "Enter your last name",
                  isRequired: true,
                  validator: (value) {
                    return profileEditController.validateLaseName(value!);
                  },
                ),
                const SizedBox(height: 16),
                // Email Field
                CustomFormRow(
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email ID",
                  controller: profileEditController.emailController,
                  focusNode: profileEditController.emailFocusNode,
                  hintText: "Enter your email",
                  isRequired: true,
                  validator: (value) {
                    return profileEditController.validateEmail(value!);
                  },
                ),
                SizedBox(height: 16),
                // Phone Number Field
                CustomFormRow(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return profileEditController.validatePhone(value!);
                  },
                  
                  labelText: "Phone Number",
                  maxLength: 10,
                  
                  controller: profileEditController.phoneNumberController,
                  focusNode: profileEditController.phoneNumberFocusNode,
                  hintText: "Enter your phone number",
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                // Address Field
                CustomFormRow(
                  validator: (value) {
                    return profileEditController.validateAddress(value!);
                  },
                  keyboardType: TextInputType.streetAddress,
                  labelText: "Address",
                  controller: profileEditController.addressController,
                  focusNode: profileEditController.addressFocusNode,
                  hintText: "Enter your address",
                  isRequired: true,
                ),
                const SizedBox(height: 32),
                mediumHeight,
                // Submit Button
                CustomButton(
                  text: 'Save',
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      profileEditController.submitForm(context);
                    }
                  },
                ),
                mediumHeight,
                mediumHeight
              ],
            ),
          ),
        ),
      ),
    );
  }
}
