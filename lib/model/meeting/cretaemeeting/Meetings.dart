class Meetings {
  Meetings({
      required this.prospectName,
      required this.address,
      required this.lastMeetinDate,});

  Meetings.fromJson(dynamic json) {
    prospectName = json['ProspectName'];
    address = json['address'];
    lastMeetinDate = json['lastMeetinDate'];

  }
  String prospectName="";
  String address="";
  String lastMeetinDate="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ProspectName'] = prospectName;
    map['address'] = address;
    map['lastMeetinDate'] = lastMeetinDate;
    return map;
  }

}