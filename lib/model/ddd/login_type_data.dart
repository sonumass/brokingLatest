class LoginTypeData {
  String id;
  String type;

  LoginTypeData({required this.id, required this.type});

  factory LoginTypeData.fromJson(Map<String, dynamic> json) {
    return LoginTypeData(
      id: json['id'] ?? "",
      type: json['type'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}
