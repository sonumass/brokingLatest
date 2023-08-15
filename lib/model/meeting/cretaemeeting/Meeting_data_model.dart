import 'Responsedata.dart';

class MeetingDataModel {
  MeetingDataModel({
      required this.responsedata,
    required this.message,
    required this.status,});

  MeetingDataModel.fromJson(dynamic json) {
    responsedata = json['responsedata'] != null ? Responsedata.fromJson(json['responsedata']) : null;
    message = json['message']??"";
    status = json['status']??"";
  }
  Responsedata? responsedata;
  String message="";
  String status="200";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final responsedata = this.responsedata;
    if (responsedata != null) {
      map['responsedata'] = responsedata.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}