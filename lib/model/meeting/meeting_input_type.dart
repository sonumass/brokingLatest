class MeetingInputModel {
  String meetingType;
  String lastMeetingDate;
  String nextMeetingDate;
  String contactPerson;
  String prospectId;
  String reminderMeetingDate;
  String reminderMeetingTime;
  List<ActionPointInputModel> actionPointData;

  MeetingInputModel(
      {required this.reminderMeetingTime,required this.reminderMeetingDate,required this.nextMeetingDate,required this.prospectId,required this.meetingType, required this.lastMeetingDate, required this.contactPerson,required this.actionPointData});

  Map toJson() => {'reminderMeetingTime':reminderMeetingTime,'reminderMeetingDate':reminderMeetingDate,'nextMeetingDate':nextMeetingDate,'prospectId':prospectId,'meetingType': meetingType, 'lastMeetingDate': lastMeetingDate, 'contactPerson': contactPerson,'actionPointData':actionPointData};
}
class ActionPointInputModel {
  String policyId;
  String actionPointText;
  String policyStatus;
  String openClosedStatus;

  ActionPointInputModel(
      {required this.policyId,required this.actionPointText, required this.policyStatus, required this.openClosedStatus});

  Map toJson() => {'policyId':policyId,'actionPointText': actionPointText, 'policyStatus': policyStatus, 'openClosedStatus': openClosedStatus};
}
