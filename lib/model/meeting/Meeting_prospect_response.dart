

import 'Meeting_prospect.dart';

class MeetingProspectResponse {
  MeetingProspectResponse({
    required this.responsedata,
    required this.message,
    required this.status,});

  MeetingProspectResponse.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      responsedata = [];
      json['responsedata'].forEach((v) {
        responsedata.add(MeetingProspect.fromJson(v));
      });
    }
    message = json['message']??"";
    status = json['status']??"";
  }
  List<MeetingProspect> responsedata=[];
  String message="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (responsedata != null) {
      map['responsedata'] = responsedata.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}