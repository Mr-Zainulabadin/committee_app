class UserModel {
  String? email, password;
  UserModel({this.email, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data1 = <String, dynamic>{};
    data1['email'] = email;
    data1['password'] = password;
    return data1;
  }
}
