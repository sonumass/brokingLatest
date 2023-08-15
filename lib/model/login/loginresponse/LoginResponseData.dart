import '../Data.dart';
import 'LoginResponseData.dart';

class LoginResponseDataModel {
  LoginResponseDataModel({
      required this.loginData,
      required this.message,
      required this.status,});

  LoginResponseDataModel.fromJson(dynamic json) {
    if (json['responsedata'] != null) {
      loginData = [];
      json['responsedata'].forEach((v) {
        loginData.add(LoginData.fromJson(v));
      });
    }
    message = json['message']??"";
    status = json['status']??"200";
  }
  List<LoginData> loginData=[];
  String message="";
  String status="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (loginData.isNotEmpty) {
      map['responsedata'] = loginData.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}