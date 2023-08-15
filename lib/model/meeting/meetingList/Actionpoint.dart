class Actionpoint {
  Actionpoint({
      required this.id,
    required this.prospectId,
    required this.meetingId,
    required this.actionpoint,
    required this.policyId,
    required this.policyStatus,
    required this.timelineTxt,
    required this.isStatus,
    required this.isDeleted,
    required this.deletedBy,
    required this.deletedDate,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.status,});

  Actionpoint.fromJson(dynamic json) {
    id = json['id']??"";
    prospectId = json['prospect_id']??"";
    meetingId = json['meeting_id']??"";
    actionpoint = json['actionpoint']??"";
    policyId = json['Policy_id']??"";
    policyStatus = json['policy_status']??"";
    timelineTxt = json['timeline_txt']??"";
    isStatus = json['is_status']??"";
    isDeleted = json['is_deleted']??"";
    deletedBy = json['deleted_by']??"";
    deletedDate = json['deleted_date']??"";
    createdBy = json['created_by']??"";
    createdDate = json['created_date']??"";
    updatedBy = json['updated_by']??"";
    updatedDate = json['updated_date']??"";
    status = json['status']??"";
  }
  String id ="";
  String prospectId="";
  String meetingId="";
  String actionpoint="";
  String policyId="";
  String policyStatus="";
  dynamic timelineTxt="";
  String isStatus="";
  String isDeleted="";
  dynamic deletedBy="";
  dynamic deletedDate="";
  String createdBy="";
  String createdDate="";
  dynamic updatedBy="";
  dynamic updatedDate="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['prospect_id'] = prospectId;
    map['meeting_id'] = meetingId;
    map['actionpoint'] = actionpoint;
    map['Policy_id'] = policyId;
    map['policy_status'] = policyStatus;
    map['timeline_txt'] = timelineTxt;
    map['is_status'] = isStatus;
    map['is_deleted'] = isDeleted;
    map['deleted_by'] = deletedBy;
    map['deleted_date'] = deletedDate;
    map['created_by'] = createdBy;
    map['created_date'] = createdDate;
    map['updated_by'] = updatedBy;
    map['updated_date'] = updatedDate;
    map['status'] = status;
    return map;
  }

}