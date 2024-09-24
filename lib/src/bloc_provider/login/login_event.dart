// login_event.dart
abstract class LoginEvent {}

class ChangeScreenType extends LoginEvent {
  final String screenType;
  ChangeScreenType(this.screenType);
}

class VerifyMobile extends LoginEvent {
  final String mobile;
  VerifyMobile(this.mobile);
}

class LoginWithMobile extends LoginEvent {
  final String mobile;
  final String otpOrPassword;
  final String type; // 'otp' or 'password'
  LoginWithMobile({required this.mobile, required this.otpOrPassword, required this.type});
}
