import 'Actionpoint.dart';

class Policies {
  Policies({
    required this.policyid,
    required this.policytype,
    required this.policyname,
    required this.actionpoint,});

  Policies.fromJson(dynamic json) {
    policyid = json['policyid']??"";
    policytype = json['policytype']??"";
    policyname = json['policyname']??"";
    if (json['actionpoint'] != null) {
      actionpoint = [];
      json['actionpoint'].forEach((v) {
        actionpoint.add(Actionpoint.fromJson(v));
      });
    }
  }
  String policyid="";
  String policytype="";
  String policyname="";
  List<Actionpoint> actionpoint=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['policyid'] = policyid;
    map['policytype'] = policytype;
    map['policyname'] = policyname;
    if (actionpoint != null) {
      map['actionpoint'] = actionpoint.map((v) => v.toJson()).toList();
    }
    return map;
  }

}