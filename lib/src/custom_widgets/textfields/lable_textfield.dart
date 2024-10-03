import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';

class CustomFormRow extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isRequired;
  final bool isEditable;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool? isReadOnly;
  final Function(String?)? onChange;

  final bool? isObs;
  final Widget? suffixWidget;
  const CustomFormRow({
    super.key,
    required this.labelText,
    required this.controller,
    required this.focusNode,
    this.hintText = '',
    this.isRequired = false,
    this.isEditable = true,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.isReadOnly, this.suffixWidget, this.isObs,  this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: screenWidth * .4,
          child: Row(
            children: [
              Text(labelText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14, fontFamily: AppFonts.medium)),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: TextFormField( 
            onChanged: onChange,
            obscureText: isObs ?? false,
            readOnly: isReadOnly ?? false,
            maxLength: maxLength,
            keyboardType: keyboardType,
            style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16),
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              suffixIcon: suffixWidget,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 14, fontFamily: AppFonts.medium),
              hintText: hintText,
              errorStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.red, fontWeight: FontWeight.w300),
              counterText: '',
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
            ),
            validator: validator,
            enabled: isEditable,
          ),
        ),
      ],
    );
  }
}
