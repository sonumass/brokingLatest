import 'package:broking/model/ddd/state_data.dart';
import 'city_data.dart';
class LocationTypeModel {

  Responsedata? responsedata;
  String message;
  String status;

  LocationTypeModel(
      {
        required this.responsedata,
        required this.message,
        required this.status});

  factory LocationTypeModel.fromJson(Map<String, dynamic> json) {
    return LocationTypeModel(
        responsedata:json['responsedata'] != null ? Responsedata.fromJson(json['responsedata']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
   data["responsedata"] = responsedata;
    return data;
  }
}

class Responsedata {

  List<StateData> state;
  List<CityData> city;

  Responsedata(
      {required this.state,
        required this.city,});

  factory Responsedata.fromJson(Map<String, dynamic> json) {
    return Responsedata(
      state: json['state'] != null
          ? (json['state'] as List)
          .map((i) => StateData.fromJson(i))
          .toList()
          : [],
      city: json['city'] != null
          ? (json['city'] as List)
          .map((i) => CityData.fromJson(i))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (state.isNotEmpty) {
      data['state'] = state.map((v) => v.toJson()).toList();
    }
    if (city.isNotEmpty) {
      data['city'] = city.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
