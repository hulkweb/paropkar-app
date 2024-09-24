// import 'package:flutter/cupertino.dart';
// import 'package:paropkar/src/services/post_api.dart';
// import 'package:paropkar/src/user_preference/user_pref/user_pref_model.dart';
// import 'package:paropkar/src/utills/constants.dart';
// import 'package:paropkar/src/utills/globle_func.dart';
// import 'package:paropkar/src/utills/navigation_function.dart';
// import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
// import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';

// import '../../user_preference/user_pref/user_preference.dart';

// class LoginController extends ChangeNotifier {
//   String _screenType = 'loginWithOtp';
//   String get screenType => _screenType;

//   changeScreenType(String screenType) {
//     mobileFieldController.clear();
//     passwordFieldController.clear();
//     otpFieldController.clear();
//     // print(screenType);
//     //loginWithOtp, loginWithPass
//     _screenType = screenType;

//     notifyListeners();
//   }

//   // mobile field
//   final mobileFieldController = TextEditingController();
//   bool _otpGetSuccess = false;
//   bool get otpGetSuccess => _otpGetSuccess;

//   otpGetSuccessFunc(value) {
//     _otpGetSuccess = value;
//     notifyListeners();
//   }

//   String? mobileValidation(value) {
//     return validatePhone(value);
//   }

//   showOtpField(value) {
//     if (mobileFieldController.text.length < 10) {
//       showCustomToast(title: 'Enter valid mobile number');
//       return;
//     }
//     otpGetSuccessFunc(value);
//   }

//   // otp field
//   final otpFieldController = TextEditingController();

//   String? otpValidation(value) {
//     if (value!.isEmpty) {
//       return 'Enter Otp';
//     }
//     if (value!.length < 6) {
//       return 'Enter Full  Otp';
//     }
//     return null;
//   }

//   final passwordFieldController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool get isPasswordVisible => _isPasswordVisible;

//   passwordVisibility(bool value) {
//     _isPasswordVisible = value;
//     notifyListeners();
//   }

//   String? passwordValidation(value) {
//     if (value!.isEmpty) {
//       return 'Enter Password';
//     }
//     if (value!.length < 8) {
//       return 'The password must be at least 8 characters';
//     }
//     return null;
//   }

//   verifyMobile(BuildContext context) {
//     showOtpField(true);
//     return;
//     postApi(
//       body: {'mobile': mobileFieldController.value.text},
//       url: '',
//       context: context,
//       onSuccess: (response) {
//         showOtpField(context);
//         showDialogBox(context,
//             type: 'success',
//             title: 'Sent Otp',
//             description: 'Otp has sent on your device');
//       },
//       onFailed: (response) {
//         showDialogBox(context,
//             type: 'success', title: 'Done', description: 'You have not login');
//       },
//       onException: () {},
//     );
//   }

//   loginWithMobile(BuildContext context, {required String type}) {
//     Map<String, String> bodyField = (type == 'otp')
//         ? {
//             'mobile': mobileFieldController.value.text,
//             'otp': otpFieldController.value.text,
//           }
//         : {
//             'mobile': mobileFieldController.value.text,
//             'password': passwordFieldController.value.text
//           };
//     if (type == 'password') {
//       bodyField.addAll({
//         'otp': '123456',
//       });
//     }
//     postApi(
//       isShowMessageToast: false,
//       body: bodyField,
//       header: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json'
//       },
//       url: AppUrl.loginMobile,
//       context: context,
//       onSuccess: (response) {
//         UserPreference userPreference = UserPreference();
//         userPreference
//             .saveUser(UserPrefModel(token: response['token'].toString()));
//         getToken();
//         showDialogBox(
//           context,
//           type: 'success',
//           title: 'Successful',
//           description: response['message'].toString(),
//           ontapOk: () {
//             AppNavigation.navigationPush(context, const BottomBarListScreen());
//           },
//         );
//       },
//       onFailed: (response) {
//         showDialogBox(
//           context,
//           type: 'error',
//           title: 'Sorry!',
//           description: response['message'].toString(),
//           ontapOk: () {
//             AppNavigation.navigationPush(
//                 context,
//                 AppNavigation.navigationPush(
//                     context, const BottomBarListScreen()));
//           },
//         );
//       },
//       onException: () {},
//     );
//   }
// }
