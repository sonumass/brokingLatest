import 'Data.dart';

class LoginDataModel {
  LoginDataModel({
      required this.response,
      required this.data,});

  LoginDataModel.fromJson(dynamic json) {
    response = json['response'];
    data = json['Data'] != null ? LoginData.fromJson(json['Data']) : null;
  }
  String? response;
  LoginData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response'] = response;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }

}