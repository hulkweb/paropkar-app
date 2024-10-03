import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/checkout/order_status_screen.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';

class PaymentCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback setPaymentStaus;

  const PaymentCard({
    super.key,
    required this.image,
    required this.title,
    required this.isSelected,
    required this.setPaymentStaus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: setPaymentStaus,
        child: Container(
          // padding: const EdgeInsets.all(1),
          // margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
            border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : Theme.of(context).cardColor),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).dividerColor.withOpacity(.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenWidth * .2,
                      width: screenWidth * .2,
                      decoration: BoxDecoration(
                          // color: AppColors.primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(image),
                      ),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: screenWidth * .5,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 16, fontFamily: AppFonts.semiBold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Continue button logic
          
          },
          child: const Text('Continue', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class OrderSuccessPopup extends StatelessWidget{
  const OrderSuccessPopup({super.key, required this.text, required this.onTrackOrder,required this.ontapGoBack});
  final String text;
  final VoidCallback onTrackOrder;
  final VoidCallback ontapGoBack;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
            ),
            // Order Success Icon
            Image.asset(
              AppAssets.orderSuccess,
              height: screenWidth * .3,
              width: screenWidth * .3,
            ),
            const SizedBox(height: 20),

            // Order Success Text
            Text(
              'Order Successful',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 24,
                  ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: AppFonts.regular,
                    color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 20),

            // "Track My Order" Button
            CustomButton(
              ontap: onTrackOrder,
              width: screenWidth * .6,
              height: 40,
              text: 'Track My Order',
            ),
            const SizedBox(
              height: 30,
            ),
            // "Go Back" Button
            OutlinedButton(
              onPressed: ontapGoBack,
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(color: AppColors.primaryColor),
              ),
              child: Text(
                'Go Back',
                style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
