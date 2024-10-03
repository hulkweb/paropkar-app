import 'package:fluttertoast/fluttertoast.dart';
import 'package:paropkar/src/user_preference/user_pref/user_pref_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(UserPrefModel responseModel) async {
    print('save user successfuly');
    print('token = ${responseModel.data!.token.toString()}');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.data!.token.toString());
    sp.setString('userId', responseModel.data!.id.toString());
    sp.setString('name', responseModel.data!.name ?? '');
    return true;
  }

  Future<UserPrefModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    String? userId = sp.getString("userId");
    return UserPrefModel(
        data: Data(token: token, id: int.parse(userId.toString())));
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}

Future<String?> getToken() async {
  UserPreference userPreference = UserPreference();
  String? token;
  await userPreference.getUser().then((value) {
    token = value.data!.token ?? '';
    print('token');
    print(token);
    // token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Bhcm9wa2FyLmpldGRpZ2l0YWwuaW4vYXBpL3Bvc3Rfb3RwX2xvZ2luIiwiaWF0IjoxNzI2ODI4MDg4LCJleHAiOjE3MjY4MzE2ODgsIm5iZiI6MTcyNjgyODA4OCwianRpIjoicEN2UHlyZnVQT05KYkRLSyIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.hz3pGML2mftfLF4OZgU9IRNMrCzIyMG6xkhp_b7_0fU';
  }).onError((error, stackTrace) {
    print('Error:-$error');
  });
  return token;
}

Future<void> logOut() async {
  UserPreference userPreference = UserPreference();
  await userPreference.removeUser();
}

Future<String> getUserId() async {
  UserPreference userPreference = UserPreference();
  String userId = '';
  await userPreference.getUser().then((value) {
    userId = value.data!.id.toString();
  }).onError((error, stackTrace) {
    print('Error:-$error');
  });
  print('======user id=====');
  print(userId);
  return userId;
}
