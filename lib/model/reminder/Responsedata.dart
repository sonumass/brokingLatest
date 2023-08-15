class ReminderCount {
  ReminderCount({
      required this.upcommingMeeting,
      required this.upcommingRenewals,
      required this.upcommingBirthday,
      required this.upcommingAniversay,});

  ReminderCount.fromJson(dynamic json) {
    upcommingMeeting = json['upcommingMeeting']??"0";
    upcommingRenewals = json['upcommingRenewals']??"0";
    upcommingBirthday = json['upcommingBirthday']??"0";
    upcommingAniversay = json['upcommingAniversay']??"0";
  }
  String upcommingMeeting="0";
  String upcommingRenewals="0";
  String upcommingBirthday="0";
  String upcommingAniversay="0";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['upcommingMeeting'] = upcommingMeeting;
    map['upcommingRenewals'] = upcommingRenewals;
    map['upcommingBirthday'] = upcommingBirthday;
    map['upcommingAniversay'] = upcommingAniversay;
    return map;
  }

}