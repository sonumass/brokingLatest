import 'ProspectDetails.dart';
import 'Contactperson.dart';
import 'Policies.dart';

class ProspectViewData {
  ProspectViewData({
      required this.prospectDetails,
      required this.contactperson,
      required this.policies,});

  ProspectViewData.fromJson(dynamic json) {
    prospectDetails = json['prospect_details'] != null ? ProspectDetails.fromJson(json['prospect_details']) : null;
    if (json['contactperson'] != null) {
      contactperson = [];
      json['contactperson'].forEach((v) {
        contactperson.add(Contactperson.fromJson(v));
      });
    }
    if (json['policies'] != null) {
      policies = [];
      json['policies'].forEach((v) {
        policies.add(Policies.fromJson(v));
      });
    }
  }
  ProspectDetails? prospectDetails;
  List<Contactperson> contactperson=[];
  List<Policies> policies=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (prospectDetails != null) {
      map['prospect_details'] = prospectDetails?.toJson();
    }
    if (contactperson != null) {
      map['contactperson'] = contactperson.map((v) => v.toJson()).toList();
    }
    if (policies != null) {
      map['policies'] = policies.map((v) => v.toJson()).toList();
    }
    return map;
  }

}