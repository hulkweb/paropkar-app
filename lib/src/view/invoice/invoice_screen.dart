import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/src/controller/notification/notification_controller.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/custom_widgets/cards/notification_card.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/view_all_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatelessWidget {
  InvoiceScreen({super.key});

  // final  addressController = AddressController();

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
          'Invoice',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 12, top: 12, right: 12,bottom: 30),
            child: Column(
              children: [
                // InvoiceCard(
                //   title: 'Product name',
                //   subtitle: 'lux soap',

                // ),
                //   InvoiceCard(
                //   title: 'description',
                //   subtitle: '12 box and each box 12 soaps',

                // ), InvoiceCard(
                //   title: 'Qty ordered',
                //   subtitle: '12 box',

                // ), InvoiceCard(
                //   title: 'price each product/box',
                //   subtitle: 'lux soap',

                // ), InvoiceCard(
                //   title: 'Product name',
                //   subtitle: '240/-',

                // ),
                // InvoiceCard(
                //   title: 'total amount',
                //   subtitle: '240 x 12',
                //   price: '2880/-',

                // ),
                // InvoiceCard(
                //   title: 'pending amount',
                //   subtitle: '6 box',
                //   price: '2880/-',

                // ),
                // InvoiceCard(
                //   title: 'total amount',
                //   subtitle: '240 x 12',
                //   price: '2880/-',

                // ),
              ],
            )),
      ),
    );
  }
}
