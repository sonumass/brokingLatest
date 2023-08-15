class Policy {
  Policy({
      required this.id,
      required this.type,});

  Policy.fromJson(dynamic json) {
    id = json['type']??"";
    type = json['type']??"";

  }
  String id="";
  String type="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    return map;
  }

}