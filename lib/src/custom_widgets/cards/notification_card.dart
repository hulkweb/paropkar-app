import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final VoidCallback onTap;
  final bool isReaded;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.image, required this.isReaded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:isReaded
              ? Colors.white  // Light gray for read notifications
              : Colors.blue[50],   // Light blue for unread notifications,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).dividerColor.withOpacity(.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CustomIconImage(
                              onPress: () {},
                              padding: 10,
                              backgroundColor: AppColors.grey.withOpacity(.4),
                              image: AppAssets.notification,
                            ),
                          ),
                          smallWidth,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenWidth*.6,
                                child: Text(
                                  title,
                                  style: Theme.of(context).textTheme.bodyLarge,overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * .5,
                                child: Text(
                                  description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontFamily: AppFonts.medium),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
