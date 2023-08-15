class Responsedata {
  Responsedata({
      required this.prospectId,
      required this.meetingwith,
      required this.reminderMeetingDate,
      required this.time,});

  Responsedata.fromJson(dynamic json) {
    prospectId = json['prospect_id']??"";
    meetingwith = json['meetingwith']??"";
    reminderMeetingDate = json['reminderMeetingDate']??"";
    time = json['time']??"00:00";
  }
  String prospectId="";
  String meetingwith="";
  String reminderMeetingDate="";
  String time="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prospect_id'] = prospectId;
    map['meetingwith'] = meetingwith;
    map['reminderMeetingDate'] = reminderMeetingDate;
    map['time'] = time;
    return map;
  }

}