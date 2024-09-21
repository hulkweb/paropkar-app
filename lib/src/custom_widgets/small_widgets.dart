import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';

PreferredSize simpleAppbar(BuildContext context,
    {void Function()? leadingFunction, List<Widget>? actions, String? title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: title != null
          ? Text(
              title,
            )
          : null,
      leading: IconButton(
        onPressed: leadingFunction ??
            () {
              Navigator.pop(context);
            },
        icon: const Padding(
          padding: EdgeInsets.only(left: 7),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      actions: actions,
      iconTheme: const IconThemeData(
        color: AppColors.backgroundColor,
        size: 20,
      ),
    ),
  );
}

// class EmptyDataShow extends StatelessWidget {
//   const EmptyDataShow({super.key, this.height, this.width});
//   final double? height;
//   final double? width;
//   Widget build(BuildContext context) {
//     return Image.asset(
//       LocalImages.emptyData,
//       height: height ?? 100 * c,
//       width: width ?? 100 * c,
//     );
//   }
// }

//  ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Ink.image(
//                         width: screenWidth * .4,
//                         height: screenWidth * .3,
//                         fit: BoxFit.cover,
//                         image: const AssetImage(ApiImages.product1),
//                       ),
//                     ),
class CenterSerialChildren extends StatelessWidget {
  const CenterSerialChildren({
    super.key,
    required this.children,
    this.width,
  });
  final List<Widget> children;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? screenWidth * .9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class CenterSerialChild extends StatelessWidget {
  const CenterSerialChild({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * .9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [child],
      ),
    );
  }
}

class SerialAlign extends StatelessWidget {
  const SerialAlign({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * .9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [child],
      ),
    );
  }
}

class CenterMainSerialChildren extends StatelessWidget {
  const CenterMainSerialChildren({
    super.key,
    required this.children,
  });
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class CenterAlign extends StatelessWidget {
  const CenterAlign({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [child],
    );
  }
}

class ImageButtonCustom extends StatelessWidget {
  const ImageButtonCustom({
    super.key,
    required this.image,
    this.ontap,
    this.size,
    this.color,
  });
  final String image;
  final void Function()? ontap;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: ontap,
        icon: ImageIcon(
          AssetImage(image),
          color: color,
          size: size ?? 25,
        ));
  }
}

Widget description14(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.black.withOpacity(.7),
      height: 1.4,
      fontFamily: AppFonts.medium,
      fontSize: 14.0,
      letterSpacing: 0.0,
    ),
    textAlign: TextAlign.center,
  );
}

Widget description16(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: AppColors.black.withOpacity(1),
      height: 1.4,
      fontFamily: AppFonts.medium,
      fontSize: 16.0,
      letterSpacing: 0.0,
    ),
  );
}

Widget description17(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: AppColors.black.withOpacity(1),
      height: 1.4,
      fontFamily: AppFonts.semiBold,
      fontSize: 16.0,
      letterSpacing: 0.0,
    ),
  );
}

Widget description12(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Color(0xff6C7072),
      height: 1.4,
      fontFamily: AppFonts.medium,
      fontSize: 12.0,
      letterSpacing: 0.0,
    ),
  );
}

showToast(
    {required String message,
    Color? textColor,
    Color? backgroundColor,
    ToastGravity? gravity,
    Toast? toastLength,
    double? fontSize}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 16.0);
}

int deleteIndex = 0;
void showDeleteConfirmationDialog(BuildContext context, Function() onYesTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onYesTap();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}

void showDisableConfirmationDialog(BuildContext context, Function() onYesTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change Status'),
        content:
            Text('Are you sure you want to change status of this business ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onYesTap();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}



class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key, required this.ontapLogout, required this.isLoading,
  });
final Function() ontapLogout;
final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * .05,
            top: screenWidth * .05,
            bottom: screenWidth * .05 / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Logout?',
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * .23),
              child: Text(
                'Are you sure want to logout from the app?',
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth,
              child: Row(
                children: [
                  Material(
                    child: CustomButton(
                      width: screenWidth * .35,
                      ontap: () {
                        Navigator.pop(context);
                      },
                      isLowerCase: true,
                      text: 'Cancel',
                      border: Border.all(color: AppColors.grey, width: 1),
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .1,
                  ),
                  Material(
                    child: CustomButton(
                      isLoading: isLoading,
                      width: screenWidth * .35,
                      ontap: ontapLogout,
                      isLowerCase: true,
                      text: 'Logout',
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .05,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
