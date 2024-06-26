class AddKametiMOdel {
  String? userId,
      fullName,
      phoneNumber,
      email,
      cnicNumber,
      perKametiPrice,
      totalKametiMonths,
      totalKametiPrice,
      startingDate,
      endingDate;
  bool? isAdmin;
  DateTime? createdDate;
  AddKametiMOdel({
    this.email,
    this.fullName,
    this.cnicNumber,
    this.phoneNumber,
    this.userId,
    this.isAdmin = false,
    this.createdDate,
    this.perKametiPrice,
    this.totalKametiMonths,
    this.totalKametiPrice,
    this.startingDate,
    this.endingDate,
  });

  AddKametiMOdel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    fullName = json['FullName'];
    cnicNumber = json['cnicNumber'];
    phoneNumber = json['phoneNumber'];
    userId = json['userId'];
    isAdmin = json['isAdmin'];
    createdDate = json['createdDate'];
    perKametiPrice = json['perKametiPrice'];
    totalKametiMonths = json['totalKametiMonths'];
    totalKametiPrice = json['totalKametiPrice'];
    startingDate = json['startingDate'];
    endingDate = json['endingDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'FullName': fullName,
      'cnicNumber': cnicNumber,
      'phoneNumber': phoneNumber,
      'userId': userId,
      'isAdmin': isAdmin,
      'createdDate': createdDate,
      "perKametiPrice": perKametiPrice,
      "totalKametiMonths": totalKametiMonths,
      "totalKametiPrice": totalKametiPrice,
      "startingDate": startingDate,
      'endingDate': endingDate
    };
  }
}
