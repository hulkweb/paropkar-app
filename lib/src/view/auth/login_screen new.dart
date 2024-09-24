// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/src/bloc_provider/login/login_bloc.dart';
import 'package:paropkar/src/bloc_provider/login/login_event.dart';
import 'package:paropkar/src/bloc_provider/login/login_state.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/utills/dimentions.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text('Login Customer')),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            } else if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Successful')),
              );
              // Navigate to another screen
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<LoginBloc>().add(ChangeScreenType('loginWithOtp'));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: state is LoginWithOtpState ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'Login With OTP',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 13,
                                color: state is LoginWithOtpState ? Colors.white : Colors.green,
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    smallWidth,
                    GestureDetector(
                      onTap: () {
                        context.read<LoginBloc>().add(ChangeScreenType('loginWithPass'));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: state is LoginWithPasswordState ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Text(
                          'Login With Password',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 13,
                                color: state is LoginWithPasswordState ? Colors.white : Colors.green,
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                state is LoginWithOtpState ? _buildOtpForm(context) : _buildPasswordForm(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOtpForm(BuildContext context) {
    final mobileController = TextEditingController();
    final otpController = TextEditingController();

    return Form(
      child: Column(
        children: [
          CustomTextFormWidget(
            controller: mobileController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            fillColor: Colors.white,
            hintText: "Mobile Number", validator: (String? value) {  },
          ),
          CustomTextFormWidget(
            controller: otpController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            fillColor: Colors.white,
            hintText: "Please Enter Otp", validator: (String? value) {  },
          ),
          CustomButton(
            ontap: () {
              context.read<LoginBloc>().add(
                    LoginWithMobile(
                      mobile: mobileController.text,
                      otpOrPassword: otpController.text,
                      type: 'otp',
                    ),
                  );
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    final mobileController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
      child: Column(
        children: [
          CustomTextFormWidget(
            controller: mobileController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            fillColor: Colors.white,
            hintText: "Mobile Number", validator: (String? value) {  },
          ),
          CustomTextFormWidget(
            controller: passwordController,
            isObs: true,
            maxLength: 15,
            keyboardType: TextInputType.visiblePassword,
            fillColor: Colors.white,
            hintText: "Password", validator: (String? value) {  },
          ),
          CustomButton(
            ontap: () {
              context.read<LoginBloc>().add(
                    LoginWithMobile(
                      mobile: mobileController.text,
                      otpOrPassword: passwordController.text,
                      type: 'password',
                    ),
                  );
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
