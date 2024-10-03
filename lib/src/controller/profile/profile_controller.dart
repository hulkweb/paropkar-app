import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paropkar/src/controller/auth_controller/login_controller.dart';
import 'package:paropkar/src/controller/auth_controller/registration_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/user/user_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/auth/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileController extends ChangeNotifier {
  DataStatus _getUserStaus = DataStatus.error;
  DataStatus get getUserStaus => _getUserStaus;

  UserDataModel? userData;
  changeUserStatus(DataStatus status) {
    print('change statas of logout $status');
    _getUserStaus = status;
    notifyListeners();
  }

  getUser(BuildContext context) async {
    print('=========================');
    changeUserStatus(DataStatus.loading);
    await getApi(
        onSuccess: (response) {
          userData = UserDataModel.fromJson(response);
          changeUserStatus(DataStatus.success);
        },
        onFailed: (p0) {
          changeUserStatus(DataStatus.error);
        },
        url: AppUrl.user_detail,
        onException: () {
          changeUserStatus(DataStatus.error);
        },
        // ignore: use_build_context_synchronously
        context: context);
    return true;
    // return isLogout;
  }


  DataStatus _logoutStaus = DataStatus.error;
  DataStatus get logoutStatus => _logoutStaus;

  changeLogoutStatus(DataStatus status) {
    print('change statas of logout $status');
    _logoutStaus = status;
    notifyListeners();
  }

  Future<bool> logoutUserApi(BuildContext context) async {
    if (DataStatus.loading == _logoutStaus) {
      return false;
    }
    changeLogoutStatus(DataStatus.loading);
    String? token = await getToken();
    bool isLogout = false;
    await postApi(
        isShowMessageToast: true,
        body: {'token': token.toString()},
        onSuccess: (response) {
          changeLogoutStatus(DataStatus.success);
          isLogout = true;
          return isLogout;
        },
        onFailed: (p0) {
          changeLogoutStatus(DataStatus.error);
          return isLogout;
        },
        url: AppUrl.logout,
        onException: () {
          changeLogoutStatus(DataStatus.error);
          return isLogout;
        },
        context: context);
    return true;
    // return isLogout;
  }

  logoutEvent(BuildContext context) async {
    // if (await logoutUserApi(context))
    if (true) {
      await logOut();
      context.read<LoginController>().disposeTextControllers();
      context.read<RegistrationController>().disposeTextControllers();
      AppNavigation.pushAndRemoveUntil(context, LoginScreen());
    }
  }
}
