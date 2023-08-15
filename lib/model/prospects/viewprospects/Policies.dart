class Policies {
  Policies({
      required this.renewalDate,
      required this.sumInsured,
      required this.premiumPotential,
      required this.policyType,
      required this.policyFile,
  required this.remark});

  Policies.fromJson(dynamic json) {
    renewalDate = json['renewalDate']??"";
    sumInsured = json['suminsured']??"";
    premiumPotential = json['premiumPotential']??"";
    policyType = json['policyType']??"";
    policyFile = json['policyFile']??"";
    remark =json['remark']??"";
  }
  String renewalDate="";
  String sumInsured="";
  String premiumPotential="";
  String policyType="";
  String policyFile="";
  String remark ="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['renewalDate'] = renewalDate;
    map['sumInsured'] = sumInsured;
    map['premiumPotential'] = premiumPotential;
    map['policyType'] = policyType;
    map['policyFile'] = policyFile;
    map['remark'] =remark;
    return map;
  }

}