class MeetingProspect {
  MeetingProspect({
      required this.prospectId,
      required this.prospectName,
      required this.adddress,
      required this.cityName,
      required this.officeId,
      required this.premiumPotential,});

  MeetingProspect.fromJson(dynamic json) {
    prospectId = json['prospectId']??"0";
    prospectName = json['prospectName']??"";
    adddress = json['adddress']??"";
    cityName = json['cityName']??"";
    officeId = json['officeId']??"";
    premiumPotential = json['premiumPotential']??"";
  }
  String? prospectId;
  String? prospectName;
  String? adddress;
  String? cityName;
  String? officeId;
  String? premiumPotential;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prospectId'] = prospectId;
    map['prospectName'] = prospectName;
    map['adddress'] = adddress;
    map['cityName'] = cityName;
    map['officeId'] = officeId;
    map['premiumPotential'] = premiumPotential;
    return map;
  }

}