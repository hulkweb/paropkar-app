import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/app_colors.dart';

import 'package:pinput/pinput.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({
    super.key,
    required this.focusNode,
    required this.pinController,
    this.onChanged,
    this.onCompleted,
  });

  final FocusNode focusNode;
  final TextEditingController pinController;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.primaryColor;
    const borderColor = AppColors.primaryColor;
    // const borderColor = Color(0xffE3E5E5);

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        // color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1.2),
      ),
    );
    return Center(
      child: Pinput(
        
        showCursor: true,
        length: 4,
        controller: pinController,
        focusNode: focusNode,
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
        // listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 10),
        validator: (value) {
          return value == ''
              ? 'Pin is Empty'
              : !(value!.length < 4)
                  ? null
                  : 'Fill all fields';
        },

        hapticFeedbackType: HapticFeedbackType.lightImpact,
        onCompleted: onCompleted,
        onChanged: onChanged,
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor, width: 2),
          ),
        ),
        submittedPinTheme: defaultPinTheme,
        onTapOutside: (event) {
          focusNode.unfocus();
        },
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
        
      ),
    );
  }
}
