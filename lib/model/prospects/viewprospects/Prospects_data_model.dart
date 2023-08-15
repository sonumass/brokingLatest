import 'Responsedata.dart';

class ProspectsDataModel {
  ProspectsDataModel({
      required this.responsedata,required this.message,required this.status});

  ProspectsDataModel.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      responsedata = [];
      json['responsedata'].forEach((v) {
        responsedata.add(ProspectViewData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
  List<ProspectViewData> responsedata=[];
  String message="";
  String status="200";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['responsedata'] = responsedata.map((v) => v.toJson()).toList();
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}