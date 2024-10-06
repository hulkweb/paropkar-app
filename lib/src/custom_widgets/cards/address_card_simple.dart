import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';

class AddressCardSimple extends StatelessWidget {
  final String addressType;
  final String address;
  final VoidCallback onTap;
  final VoidCallback ontapEdit;
  final VoidCallback ontapDelete;
  final bool isDefault;

  final String phone;
  const AddressCardSimple({
    super.key,
    required this.addressType,
    required this.address,
    required this.onTap,
    required this.ontapEdit,
    required this.ontapDelete,
    required this.isDefault,
    required this.phone,
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
            color: Theme.of(context).cardColor,
            border: Border.all(
                color: isDefault ? AppColors.primaryColor : AppColors.white),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).dividerColor.withOpacity(.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 0, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset(
                                  AppAssets.location,
                                  height: 25,
                                  width: 25,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: screenWidth * .48,
                                    child: Text(
                                      address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontFamily: AppFonts.medium),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * .48,
                                    child: Text(
                                      phone,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: ontapEdit,
                          icon: Icon(Icons.edit,
                              color: Theme.of(context).primaryColor),
                        ),
                        IconButton(
                          onPressed: ontapDelete,
                          icon: Icon(Icons.delete,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
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
