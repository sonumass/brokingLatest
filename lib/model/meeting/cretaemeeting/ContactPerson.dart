class ContactPerson {
  ContactPerson({
    required this.id,
      required this.type,});

  ContactPerson.fromJson(dynamic json) {
    type = json['type'];
    id = json['id'];
  }
  String id="";
  String type="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['id'] = id;
    return map;
  }

}