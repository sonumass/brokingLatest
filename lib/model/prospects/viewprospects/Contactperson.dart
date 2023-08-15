class Contactperson {
  Contactperson({
    required this.contactPersonId,
    required this.prospectId,
    required this.personName,
    required  this.designation,
    required this.personLocation,
    required this.email,
    required this.phone,
    required this.decesionMaker,
    required this.phone2,
    required this.birthday,
    required this.anniversary,});

  Contactperson.fromJson(dynamic json) {
    contactPersonId = json['contactPersonId']??"";
    prospectId = json['prospectId']??"";
    personName = json['personName']??"";
    designation = json['designation']??"";
    personLocation = json['personLocation']??"";
    email = json['email']??"";
    phone = json['phone']??"";
    decesionMaker = json['decesionMaker']??"";
    phone2 = json['phone2'] ?? "";
    birthday = json['birthday'] ?? "";
    anniversary = json['anniversary'] ?? "";
  }
  String contactPersonId="";
  String prospectId="";
  String personName="";
  String designation="";
  String personLocation="";
  String email="";
  String phone="";
  String decesionMaker="";
  String? phone2="";
  String? birthday="";
  String? anniversary="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactPersonId'] = contactPersonId;
    map['prospectId'] = prospectId;
    map['personName'] = personName;
    map['designation'] = designation;
    map['personLocation'] = personLocation;
    map['email'] = email;
    map['phone'] = phone;
    map['decesionMaker'] = decesionMaker;
    map['phone2'] = phone2;
    map['birthday'] = birthday;
    map['anniversary'] = anniversary;
    return map;
  }

}