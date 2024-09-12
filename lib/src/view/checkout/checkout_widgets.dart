import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/checkout_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/checkout/order_status_screen.dart';
import 'package:paropkar/src/widgets/custom_button.dart';
import 'package:paropkar/src/widgets/custom_image_icon.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  final String addressType;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressCard({
    Key? key,
    required this.addressType,
    required this.address,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).dividerColor.withOpacity(.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 10, top: 0, bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addressType,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: screenWidth * .5,
                        child: Text(
                          address,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Edit address action
                  },
                  icon: Icon(Icons.edit, color: Theme.of(context).hintColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
          child: Text('Continue', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

class OrderSuccessPopup extends StatelessWidget {
  const OrderSuccessPopup({super.key});

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
                'Your order #34567 is successfully placed',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: AppFonts.regular,
                    color: AppColors.primaryColor),
              ),
            ),
            const SizedBox(height: 20),

            // "Track My Order" Button
            CustomButton(
              ontap: () {
                // Handle Track My Order action
                AppNavigation.navigation(context, OrderStatusScreen());
              },
              width: screenWidth * .6,
              height: 40,
              text: 'Track My Order',
            ),
            const SizedBox(
              height: 30,
            ),
            // "Go Back" Button
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(color: AppColors.primaryColor),
              ),
              child: Text(
                'Go Back',
                style: TextStyle(fontSize: 16, color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
