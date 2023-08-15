import 'MeetingData.dart';

class MeetingList {
  MeetingList({
      required this.meetingData,
      required this.message,
      required this.status,});

  MeetingList.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      meetingData = [];
      json['responsedata'].forEach((v) {
        meetingData.add(MeetingData.fromJson(v));
      });
    }
    message = json['message']??"";
    status = json['status']??"";
  }
  List<MeetingData> meetingData=[];
  String message="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (meetingData.isNotEmpty) {
      map['responsedata'] = meetingData.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}