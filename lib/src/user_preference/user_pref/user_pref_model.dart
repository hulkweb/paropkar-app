class UserPrefModel {
  String? token;
   String? userId;
  bool? isUserManager;
    String? name;
  String? salonId;
  String? salonName;
  bool? petSalon;
  UserPrefModel({this.token,this.userId, this.isUserManager, this.salonId, this.salonName,this.petSalon
  // ,this.isLogin,this.name,this.phone,this.email,this.profile_image,
  });

  UserPrefModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    isUserManager = json['isUserManager'];
    salonId = json['salonId'];
    salonName = json['salonName'];
    petSalon = json['petSalon'];
    // profile_image = json['profile_image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['isUserManager'] = this.isUserManager;
    data['salonId'] = this.salonId;
    data['salonName'] = this.salonName;
    data['petSalon']  = this.petSalon;
    // data['email'] = this.email;
    // data['profile_image'] = this.profile_image;
    return data;
  }
}
