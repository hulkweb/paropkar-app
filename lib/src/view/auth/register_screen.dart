import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/auth_controller/registration_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/custom_widgets/comman_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final registrationController = RegistrationController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationController>(
        builder: (context, registrationController, child) {
      return CommanWidget(
        title: 'Register Customer',
        widget: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Toggle Buttons
                  smallHeight,
                  CustomTextFormWidget(
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    fillColor: AppColors.white,
                    controller: registrationController.nameController,
                    hintText: "Enter Name",
                    validator: (value) {
                      return registrationController.nameValidation(value,
                          emptyText: 'Enter Your Name');
                    },
                  ),
                  smallHeight,
                  CustomTextFormWidget(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    fillColor: AppColors.white,
                    controller: registrationController.phoneController,
                    hintText: "Enter  Phone Number",
                    validator: (value) {
                      return registrationController.mobileValidation(value);
                    },
                  ),
                  smallHeight,
                  CustomTextFormWidget(
                    maxLength: 50,
                    keyboardType: TextInputType.emailAddress,
                    fillColor: AppColors.white,
                    controller: registrationController.emailController,
                    hintText: "Enter  Email",
                    validator: (value) {
                      return registrationController.validateEmail(value);
                    },
                  ),
                  smallHeight,
                  CustomTextFormWidget(
                      maxLength: 50,
                      keyboardType: TextInputType.visiblePassword,
                      fillColor: AppColors.white,
                      controller: registrationController.passwordController,
                      hintText: "Enter  Password",
                      validator: (value) {
                        return registrationController.passwordValidation(value);
                      },
                      onFieldSubmitted: (p0) {
                        if (_formKey.currentState!.validate()) {
                          registrationController.register(context);
                        }
                      }),
                  SizedBox(
                    height: screenHeight * .05,
                  ),
                  CustomButton(
                      isLoading: registrationController.registerDataStatus ==
                          DataStatus.loading,
                      ontap: () {
                        if (_formKey.currentState!.validate()) {
                          registrationController.register(context);
                        }
                      },
                      text: 'Verify'),
                  smallHeight
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
