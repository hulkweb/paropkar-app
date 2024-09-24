// login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/bloc_provider/login/login_event.dart';
import 'package:paropkar/src/bloc_provider/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<ChangeScreenType>(_onChangeScreenType);
    on<VerifyMobile>(_onVerifyMobile);
    on<LoginWithMobile>(_onLoginWithMobile);
  }

  void _onChangeScreenType(ChangeScreenType event, Emitter<LoginState> emit) {
    if (event.screenType == 'loginWithOtp') {
      emit(LoginWithOtpState());
    } else {
      emit(LoginWithPasswordState());
    }
  }

  void _onVerifyMobile(VerifyMobile event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      // Add your API call logic for verifying the mobile number here
      await Future.delayed(Duration(seconds: 2)); // Mock API delay
      emit(MobileVerified());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  void _onLoginWithMobile(LoginWithMobile event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      // Add your API call logic for logging in here
      await Future.delayed(Duration(seconds: 2)); // Mock API delay
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
