import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/enter_shops_pincode.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_textfied.dart';
import 'package:paropkar/src/widgets/otp_custom.dart';

class EnterShopNameScreen extends StatelessWidget {
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
                'Enter Shop’s name',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding:  EdgeInsets.only(left: screenWidth*.1,right: screenWidth*.1),

                child: Text(
                  'You shop or business name will be used to create invoice',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: AppColors.primaryColor),textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                contentpadding:EdgeInsets.only(left: 20, bottom: 20,top: 10),
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
                        builder: (context) => EnterShopsPincodeScreen()),
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
