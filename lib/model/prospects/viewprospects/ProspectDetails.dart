class ProspectDetails {
  ProspectDetails({
      required this.prospectId,
      required this.prospectName,
      required this.totalMeeting,
      required this.adddress,
      required this.pinCode,
      required this.cityName,
      required this.officeId,
      required this.industryType,
      required this.turnover,
      required this.parentCompany,
      required this.premiumClosed,
      required this.corporateOffice,
      required this.writeupNotes,
      required this.referee,});

  ProspectDetails.fromJson(dynamic json) {
    prospectId = json['prospectId']??"";
    prospectName = json['prospectName']??"";
    totalMeeting = json['totalMeeting']??"";
    adddress = json['adddress']??"";
    pinCode = json['pinCode']??"";
    cityName = json['cityName']??"";
    officeId = json['officeId']??"";
    industryType = json['industryType']??"";
    turnover = json['turnover']??"";
    parentCompany = json['parentCompany']??"";
    premiumClosed = json['premiumClosed']??"";
    corporateOffice = json['corporateOffice']??"";
    writeupNotes = json['writeupNotes']??"";
    referee = json['referee']??"";
    premiumPotential =json['premiumPotential']??"0";
    premiumAchived =json['premiumAchived']??"0";
  }
  String prospectId="";
  String prospectName="";
  String totalMeeting="";
  String adddress="";
  String pinCode="";
  String cityName="";
  String officeId="";
  String industryType="";
  String turnover="";
  String parentCompany="";
  String premiumClosed="";
  String corporateOffice="";
  String premiumPotential="";
  String premiumAchived="";
  String writeupNotes="";
  String referee="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prospectId'] = prospectId;
    map['prospectName'] = prospectName;
    map['totalMeeting'] = totalMeeting;
    map['adddress'] = adddress;
    map['pinCode'] = pinCode;
    map['cityname'] = cityName;
    map['cityName'] = officeId;
    map['industrytype'] = industryType;
    map['turnover'] = turnover;
    map['parentcompany'] = parentCompany;
    map['premiumClosed'] = premiumClosed;
    map['corporateOffice'] = corporateOffice;
    map['premiumPotential'] = premiumPotential;
    map['premiumAchived'] = premiumAchived;
    map['writeupNotes'] = writeupNotes;
    map['referee'] = referee;
    return map;
  }

}