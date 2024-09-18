import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/dimentions.dart';

class DialogBox extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final VoidCallback? ontapOk;
  const DialogBox({
    Key? key,
    required this.title,
    required this.description,
    required this.type,  this.ontapOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: screenHeight * .42,
        child: Stack(
          children: [
            Dialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: screenHeight * .33,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Success Icon

                    Expanded(
                        child: SizedBox(
                      height: screenHeight * .04,
                    )),
                    // Title
                    Text(title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(
                      height: screenHeight * .04,
                    ),
                    // Description
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: screenHeight * .04,
                    )),
                    // OK Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor:
                              AppColors.primaryColor, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed:ontapOk?? () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text("OK",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Theme.of(context).cardColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: type == 'success'
                              ? AppColors.primaryColor
                              : AppColors.errorColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          type == 'success' ? Icons.check : Icons.close,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
