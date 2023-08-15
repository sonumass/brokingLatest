import 'Responsedata.dart';

class AlarmModel {
  AlarmModel({
      required this.responsedata,
      required this.message,
      required this.status,});

  AlarmModel.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      responsedata = [];
      json['responsedata'].forEach((v) {
        responsedata.add(Responsedata.fromJson(v));
      });
    }
    message = json['message']??"";
    status = json['status']??"";
  }
  List<Responsedata> responsedata=[];
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