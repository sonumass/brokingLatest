import 'package:broking/model/ddd/login_type_data.dart';


class Responsedata {
  Responsedata({
      required this.premiumPotential,
      required this.industryType,
      required this.vertical,
      required this.policyType,});

  Responsedata.fromJson(dynamic json) {
    if (json['premium_potential'] != null) {
      premiumPotential = [];
      json['premium_potential'].forEach((v) {
        premiumPotential.add(LoginTypeData.fromJson(v));
      });
    }
    if (json['Industry_type'] != null) {
      industryType = [];
      json['Industry_type'].forEach((v) {
        industryType.add(LoginTypeData.fromJson(v));
      });
    }
    if (json['Vertical'] != null) {
      vertical = [];
      json['Vertical'].forEach((v) {
        vertical.add(LoginTypeData.fromJson(v));
      });
    }
    if (json['Policy_type'] != null) {
      policyType = [];
      json['Policy_type'].forEach((v) {
        policyType.add(LoginTypeData.fromJson(v));
      });
    }
  }
  List<LoginTypeData> premiumPotential=[];
  List<LoginTypeData> industryType=[];
  List<LoginTypeData> vertical=[];
  List<LoginTypeData> policyType=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['premium_potential'] = premiumPotential.map((v) => v.toJson()).toList();
    map['Industry_type'] = industryType.map((v) => v.toJson()).toList();
    map['Vertical'] = vertical.map((v) => v.toJson()).toList();
    map['Policy_type'] = policyType.map((v) => v.toJson()).toList();
    return map;
  }

}