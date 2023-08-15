class StateData {
  String id;
  String stateName;

  StateData({required this.id, required this.stateName,});

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      id: json['id'] ?? "",
      stateName: json['state_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state_name'] = stateName;
    return data;
  }
}
