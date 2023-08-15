import 'package:broking/model/reminder/detailList/response_data_List.dart';


class ReminderDetailListModel {
  ReminderDetailListModel({
      required this.responsedata,
      required this.message,
      required this.status,});

  ReminderDetailListModel.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      responsedata = [];
      json['responsedata'].forEach((v) {
        responsedata.add(ReminderDataList.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  List<ReminderDataList> responsedata=[];
  String message="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responsedata'] = responsedata.map((v) => v.toJson()).toList();
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}