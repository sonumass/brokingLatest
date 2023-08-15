class DataList {
  DataList({
    required this.label,
    required this.value,
  });

  DataList.fromJson(dynamic json) {
    label = json['label'] ?? "";
    value = json['value'] ?? "";
  }

  String label = "";
  String value = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    return map;
  }
}
