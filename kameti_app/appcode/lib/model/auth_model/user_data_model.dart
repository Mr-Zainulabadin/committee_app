class UserDataModel {
  String? userId, fullName, phoneNumber, email, cnicNumber;
  bool? isAdmin;
  DateTime? createdDate;
  UserDataModel({
    this.email,
    this.fullName,
    this.cnicNumber,
    this.phoneNumber,
    this.userId,
    this.isAdmin = false,
    this.createdDate,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    fullName = json['FullName'];
    cnicNumber = json['cnicNumber'];
    phoneNumber = json['phoneNumber'];
    userId = json['userId'];
    isAdmin = json['isAdmin'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'FullName': fullName,
      'cnicNumber': cnicNumber,
      'phoneNumber': phoneNumber,
      'userId': userId,
      'isAdmin': isAdmin,
      'createdDate': createdDate
    };
  }
}
