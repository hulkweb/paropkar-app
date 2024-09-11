import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/enter_shopname_screen.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';
import 'package:paropkar/src/widgets/otp_custom.dart';

class EnterNameScreen extends StatelessWidget {
  const EnterNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommanWidget(
      widget: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Toggle Buttons
              
              const SizedBox(
                height: 50,
              ),

              Text(
                'Enter Your Name',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                fillColor: AppColors.white,
                hintText: "Full Name",
                validator: (String? value) {},
              ),
              SizedBox(
                height: screenHeight * .2,
              ),
              CustomButton(
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EnterShopNameScreen()),
                  );
                },
                text: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
