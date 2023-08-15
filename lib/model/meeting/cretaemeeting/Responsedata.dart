import '../../ddd/login_type_data.dart';
import 'Meetings.dart';

class Responsedata {
  Responsedata({
      required this.meetings,
      required this.policy,
      required this.contactPerson,});

  Responsedata.fromJson(dynamic json) {
    if (json['Meetings'] != null) {
      meetings = [];
      json['Meetings'].forEach((v) {
        meetings.add(Meetings.fromJson(v));
      });
    }
    if (json['policy'] != null) {
      policy = [];
      json['policy'].forEach((v) {
        policy.add(LoginTypeData.fromJson(v));
      });
    }
    if (json['contactPerson'] != null) {
      contactPerson = [];
      json['contactPerson'].forEach((v) {
        contactPerson.add(LoginTypeData.fromJson(v));
      });
    }
  }
  List<Meetings> meetings=[];
  List<LoginTypeData> policy=[];
  List<LoginTypeData> contactPerson=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (meetings.isNotEmpty) {
      map['Meetings'] = meetings.map((v) => v.toJson()).toList();
    }
    if (policy.isNotEmpty) {
      map['policy'] = policy.map((v) => v.toJson()).toList();
    }
    if (contactPerson.isNotEmpty) {
      map['contactPerson'] = contactPerson.map((v) => v.toJson()).toList();
    }
    return map;
  }

}