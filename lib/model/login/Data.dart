class LoginData {
  LoginData({
      required this.id,
    required this.type,
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.officeId,});

  LoginData.fromJson(dynamic json) {
    id = json['id']??"";
    type = json['type']??"";
    username = json['username']??"";
    password = json['password']??"";
    email = json['email']??"";
    firstName = json['first_name']??"";
    lastName = json['last_name']??"";
    phone = json['phone']??"";
    officeId = json['office_id']??"";
  }
  String id="";
  String type="";
  String username="";
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
    map['username'] = username;
    map['password'] = password;
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone'] = phone;
    map['office_id'] = officeId;
    return map;
  }

}