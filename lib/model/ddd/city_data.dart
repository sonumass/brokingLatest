class CityData {
  String id;
  String stateId;
  String cityName;

  CityData({required this.id, required this.stateId,required this.cityName});

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'] ?? "",
      stateId: json['state_id'] ?? "",
      cityName: json['city_name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['state_id'] = stateId;
    data['city_name'] = cityName;
    return data;
  }
}
