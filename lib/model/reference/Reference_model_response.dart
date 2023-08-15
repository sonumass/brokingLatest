import 'Responsedata.dart';

class ReferenceModelResponse {
  ReferenceModelResponse({
      required this.responsedata,
      required this.message,
      required this.status,});

  ReferenceModelResponse.fromJson(dynamic json) {
    responsedata = json['responsedata'] != null ? Responsedata.fromJson(json['responsedata']) : null;
    message = json['message']??"";
    status = json['status']??"";
  }
  Responsedata? responsedata;
  String message="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (responsedata != null) {
      map['responsedata'] = responsedata!.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}