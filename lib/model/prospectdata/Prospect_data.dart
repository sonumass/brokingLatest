import 'Responsedata.dart';

class ProspectData {
  ProspectData({
    required this.responsedata,
    required this.message,
    required this.status,});

  ProspectData.fromJson(dynamic json) {
    responsedata = json['responsedata'] != null ? Responsedata.fromJson(json['responsedata']) : null;
    message = json['message']??"";
    status = json['status']??"203";
  }
  Responsedata? responsedata;
  String message="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responsedata'] = responsedata!.toJson();
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}