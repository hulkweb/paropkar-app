import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/widgets/custom_image_icon.dart';




class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
            onPress: () {},
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
          'Edit Profile',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: screenWidth * .16,
                  width: screenWidth * .16,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage(
                            AppAssets.profile,
                          ),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Somya Jain',
                      style:
                          Theme.of(context).textTheme.titleMedium!.copyWith(),
                    ),
                    Text(
                      '+91-9876543210',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Column(
              children: [
                Row(
                  children: [],
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: const [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
