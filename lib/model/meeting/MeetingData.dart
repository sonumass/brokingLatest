class MeetingData {
  MeetingData({
    required this.meetingId,
    required this.prospectId,
    required this.lastVisiDate,
    required this.lastVisitTime,
    required this.nextFollowUpDate,
    required this.nextFollowUpTime,
    required this.personMeet,
    required this.actionpoint,
  });

  MeetingData.fromJson(dynamic json) {
    meetingId = json['meetingId']??"";
    prospectId = json['prospectId']??"";
    lastVisiDate = json['lastVisiDate']??"";
    lastVisitTime = json['lastVisitTime']??"";
    nextFollowUpDate = json['nextFollowUpDate']??"";
    nextFollowUpTime = json['nextFollowUpTime']??"";
    personMeet = json['personMeet']??"";
    actionpoint = json['actionpoint']??"";
  }

  String meetingId="";
  String prospectId="";
  String lastVisiDate="";
  String lastVisitTime="";
  String nextFollowUpDate="";
  String nextFollowUpTime="";
  String personMeet="";
  String actionpoint="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['meetingId'] = meetingId;
    map['prospectId'] = prospectId;
    map['lastVisiDate'] = lastVisiDate;
    map['lastVisitTime'] = lastVisitTime;
    map['nextFollowUpDate'] = nextFollowUpDate;
    map['nextFollowUpTime'] = nextFollowUpTime;
    map['personMeet'] = personMeet;
    map['actionpoint'] = actionpoint;
    return map;
  }
}
