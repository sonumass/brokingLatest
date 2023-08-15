import 'MeetingDataList.dart';

class MeetingListResponse {
  MeetingListResponse({
    required this.responsedata,
    required this.message,
    required this.status,});

  MeetingListResponse.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      responsedata = [];
      json['responsedata'].forEach((v) {
        responsedata.add(MeetingDataList.fromJson(v));
      });
    }
    message = json['message']??"";
    status = json['status']??"";
  }
  List<MeetingDataList> responsedata=[];
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