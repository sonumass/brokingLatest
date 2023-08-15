import 'package:broking/model/ddd/LoginTypeModel.dart';

import '../ddd/login_type_data.dart';


class Responsedata {
  Responsedata({
      required this.premiumPotential,
      required this.policyType,});

  Responsedata.fromJson(dynamic json) {
    if (json['premium_potential'] != null) {
      premiumPotential = [];
      json['premium_potential'].forEach((v) {
        premiumPotential.add(LoginTypeData.fromJson(v));
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
  List<LoginTypeData> policyType=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['premium_potential'] = premiumPotential.map((v) => v.toJson()).toList();
    map['Policy_type'] = policyType.map((v) => v.toJson()).toList();
    return map;
  }

}