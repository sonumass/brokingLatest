class LoginData {
  LoginData({
      required this.id,
    required this.type,
    required this.userName,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.officeId,});

  LoginData.fromJson(dynamic json) {
    id = json['id']??"";
    type = json['type']??"";
    userName = json['userName']??"";
    password = json['password']??"";
    email = json['email']??"";
    firstName = json['firstName']??"";
    lastName = json['lastName']??"";
    phone = json['phone']??"";
    officeId = json['officeId']??"";
  }
  String id="";
  String type="";
  String userName="";
  String password="";
  String email="";
  String firstName="";
  String lastName="";
  String phone="";
  String officeId="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['userName'] = userName;
    map['password'] = password;
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['phone'] = phone;
    map['officeId'] = officeId;
    return map;
  }

}