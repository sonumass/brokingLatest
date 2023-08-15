class ContactItemInput {
  String contactpersonid;
  String prospectid;
  String personname;
  String designation;
  String personlocation;
  String email;
  String phone;
  String decesionmaker;
  String phone2;
  String birthday;
  String anniversary;

  ContactItemInput({
    required this.contactpersonid,
    required this.prospectid,
    required this.personname,
    required this.designation,
    required this.personlocation,
    required this.email,
    required this.phone,
    required this.decesionmaker,
    required this.phone2,
    required this.birthday,
    required this.anniversary,
  });

  Map toJson() => {
        'contactpersonid': contactpersonid,
        'prospectid': prospectid,
        'contact_person_name': personname,
        'contact_person_designation': designation,
        'contact_person_location': personlocation,
        'contact_person_email_ID': email,
        'contact_person_phone1': phone,
        'contact_person_key_decision_maker': decesionmaker,
        'contact_person_phone2': phone2,
        'birthday': birthday,
        'anniversary': anniversary,
      };
}
