
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paropkar/src/user_preference/user_pref/user_pref_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(UserPrefModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.token.toString());
    sp.setString('userId', responseModel.userId.toString());
    sp.setBool('isUserManager', responseModel.isUserManager ?? false);

    sp.setBool('petSalon', responseModel.petSalon ?? false);
    // sp.setString('name', responseModel.name!);
    sp.setString('salonId', responseModel.salonId ?? '');
    sp.setString('salonName', responseModel.salonName ?? '');
    // sp.setString('profile_image', responseModel.profile_image!);
    return true;
  }

  Future<UserPrefModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    String? userId = sp.getString("userId");
    bool? isUserManager = sp.getBool("isUserManager");
    String? salonId = sp.getString("salonId");
    String? salonName = sp.getString("salonName");
    bool? petSalon = sp.getBool("petSalon");
    return UserPrefModel(
        token: token,
        userId: userId,
        isUserManager: isUserManager,
        salonId: salonId,
        salonName: salonName,
        petSalon: petSalon);
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}

Future<String> getToken() async {
  UserPreference userPreference = UserPreference();
  String token = '';
  await userPreference.getUser().then((value) {
    token = value.token ?? '';
    // token = '665fe0e4d1fd549f010024a2|3JHzMZG9MlhOwTDQfrfqZSNEK2M7zY6pwLWNTDvc';
  }).onError((error, stackTrace) {
    print('Error:-$error');
  });
  return token;
}

Future<void> logOut() async {
  UserPreference userPreference = UserPreference();
  await userPreference.removeUser();
  Fluttertoast.showToast(msg: 'logout successfully');
}


Future<String> getUserId() async {
  UserPreference userPreference = UserPreference();
  String userId = '';
  await userPreference.getUser().then((value) {
    userId = value.userId ?? '';
  }).onError((error, stackTrace) {
    print('Error:-$error');
  });
  return userId;
}