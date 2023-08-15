class PolicyItemInput {
  String policyid="";
  String renewalDate="";
  String suminsured="";
  String premium="";
  String policyName="";
  String remarks="";
  String uploadDoc="";
  String fileExt="jpg";
  PolicyItemInput({
    this.policyid="",
    required this.renewalDate,
    required this.suminsured,
    required this.premium,
    required this.policyName,
    required this.remarks,
    required this.uploadDoc,
    this.fileExt="jpg"
  });
  Map toJson() => {
    "policyid":policyid,
    'renewal_date': renewalDate,
    'Sum_insured': suminsured,
    'Premium': premium,
    'policyname': policyName,
    'Remarks': remarks,
    'upload_doc': uploadDoc,
    'fileExt': fileExt,
  };
}
