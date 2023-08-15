

class ProspectDetailInput {
  String id="";
  String email="";
  String userId="";
  String officeId="";
  String prospectName="";
  String totalMeeting="";
  String adddress="";
  String pinCode="";
  String cityName="";
  String state="";
  String industryType="";
  String turnover="";
  String parentCompany="";
  String premiumClosed="";
  String corporateOffice="";
  String referee="";
  String premiumPotential="";
  String premiumAchieved="";
  String vertical="";
  String writeUp="";

  ProspectDetailInput({
    required this.id,
    required this.email,
    required this.userId,
    required this.officeId,
    required this.prospectName,
    required this.totalMeeting,
    required this.adddress,
    required this.state,
    required this.pinCode,
    required this.cityName,
    required this.industryType,
    required this.turnover,
    required this.parentCompany,
    required this.premiumClosed,
    required this.corporateOffice,
    required this.premiumPotential,
    required this.premiumAchieved,
    required this.vertical,
    required this.writeUp,
    required this.referee,
  });

  Map toJson() => {
        'id': id,
    "email":email,
    "user_id":userId,
    "office_id":officeId,
    "prospect_name":prospectName,
    "prospect_address":adddress,
    "state":state,
    "city":cityName,
    "pin_code":pinCode,
    "parent_company":parentCompany,
    "office_address":corporateOffice,
    "turnover":turnover,
    "premium_potential":premiumPotential,
    "premium_achieved":premiumAchieved,
    "vertical":vertical,
    "industry_type":industryType,
    "write_up":writeUp,
    "name_of_referee":referee,
      };
}
