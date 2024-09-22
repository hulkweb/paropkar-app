abstract class LoginEvent {}

class LoginWithMobilePassword extends LoginEvent {
  final String mobile;
  final String password;
  LoginWithMobilePassword(
    this.mobile,
    this.password,
  );
}

class LoginWithMobileOtp extends LoginEvent {
  final String mobile;
  final String otp;
  LoginWithMobileOtp(
    this.mobile,
    this.otp,
  );
}

class MobileVerify extends LoginEvent {
  final String mobile;
  MobileVerify(
    this.mobile,
  );
}
