import 'Policies.dart';

class MeetingDataList {
  MeetingDataList({
    required this.meetingId,
    required this.prospectId,
    required this.prospectName,
    required this.nextMeetingdate,
    required this.personMeet,
    required this.lastMeetingdate,
    required this.prospectAddress,
    required this.meetingStatus,
    required this.policies,});

  MeetingDataList.fromJson(dynamic json) {
    meetingId = json['meetingId']??"";
    prospectId = json['prospectId']??"";
    prospectName = json['ProspectName']??"";
    nextMeetingdate = json['nextMeetingdate']??"";
    personMeet = json['personMeet']??"";
    lastMeetingdate = json['lastMeetingdate']??"";
    prospectAddress = json['prospectAddress']??"";
    meetingStatus = json['meetingStatus']??"";
    if (json['policies'] != null) {
      policies = [];
      json['policies'].forEach((v) {
        policies.add(Policies.fromJson(v));
      });
    }
  }
  String meetingId="";
  String prospectId="";
  String prospectName="";
  String nextMeetingdate="";
  String personMeet="";
  String lastMeetingdate="";
  String prospectAddress ="";
  dynamic meetingStatus="";
  List<Policies> policies=[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meetingId'] = meetingId;
    map['prospectId'] = prospectId;
    map['ProspectName'] = prospectName;
    map['nextMeetingdate'] = nextMeetingdate;
    map['personMeet'] = personMeet;
    map['lastMeetingdate'] = lastMeetingdate;
    map['prospectAddress'] = prospectAddress;
    map['meetingStatus'] = meetingStatus;
    if (policies != null) {
      map['policies'] = policies.map((v) => v.toJson()).toList();
    }
    return map;
  }

}