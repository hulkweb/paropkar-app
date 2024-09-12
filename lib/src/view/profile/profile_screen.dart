import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/profile/edit_profile.dart';
import 'package:paropkar/src/widgets/custom_image_icon.dart';

// Colors for the theme
const primaryColor =
    Color(0xFF00A55B); // Example primary color (adjust as per design)
const greyColor = Color(0xFF757575); // Example grey color for text
const whiteColor = Color(0xFFFFFFFF); // Example white background

// Main Cart Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
          'My Profile',
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
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                ListTileProfileSction(
                  ontap: () {
                    AppNavigation.navigation(context, EditProfileScreen());
                  },
                  image: AppAssets.editProfile,
                  title: 'Edit profile',
                  padding: 8,
                ),
                ListTileProfileSction(
                    ontap: () {},
                    image: AppAssets.changePassword,
                    title: 'Change password',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {},
                    image: AppAssets.location,
                    title: 'My address',
                    padding: 5),
                ListTileProfileSction(
                    ontap: () {},
                    image: AppAssets.appInfo,
                    title: 'App information',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {},
                    image: AppAssets.language,
                    title: 'Language',
                    padding: 8),
                ListTileProfileSction(
                    ontap: () {},
                    image: AppAssets.logout,
                    title: 'Logout',
                    padding: 8),
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

class ListTileProfileSction extends StatelessWidget {
  const ListTileProfileSction({
    super.key,
    required this.ontap,
    required this.image,
    required this.title,
    required this.padding,
  });
  final VoidCallback ontap;
  final String image;
  final String title;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIconImage(
              padding: padding,
              onPress: ontap,
              image: image,
              backgroundColor: AppColors.primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
                child: SizedBox(
              width: 10,
            )),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}
