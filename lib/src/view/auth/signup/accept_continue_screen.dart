import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_textstyles.dart';
import 'package:paropkar/src/view/auth/signup/enter_name_screen.dart';
import 'package:paropkar/src/view/auth/signup/signup_screen.dart';
import 'package:paropkar/src/widgets/comman_widget.dart';
import 'package:paropkar/src/widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/widgets/otp_custom.dart';

class AcceptContinueScreen extends StatelessWidget {
  
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
                'Get Started With App',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * .16,
                  right: screenWidth * .16,
                ),
                child: Text(
                  'By continuining and acepting, you agree to',
                  style: Theme.of(context).textTheme.labelMedium!,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenHeight * .2,
              ),
               CustomButton(
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EnterNameScreen()),
                  );
                },
                text: 'Accept And Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
