import 'Responsedata.dart';

class ReminderCountModel {
  ReminderCountModel({
      required this.responsedata,
      required this.message,
      required this.status,});

  ReminderCountModel.fromJson(dynamic json) {
    responsedata = json['responsedata'] != null ? ReminderCount.fromJson(json['responsedata']) : null;
    message = json['message']??"";
    status = json['status']??"203";
  }
  ReminderCount? responsedata;
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