import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';
import 'package:paropkar/src/widgets/otp_custom.dart';

class EnterShopsPincodeScreen extends StatelessWidget {
  const EnterShopsPincodeScreen({super.key});

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
                'Enter Shop’s Pincode',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(
                height: screenHeight * .1,
              ),
              Row(
                children: [
                  Text(
                    'Enter 6 Digit',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormWidget(
                fillColor: AppColors.white,
                hintText: "452022",
                validator: (String? value) {},
              ),
              SizedBox(
                height: screenHeight * .1,
              ),
              CustomButton(
                text: 'Continue',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomBarListScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
