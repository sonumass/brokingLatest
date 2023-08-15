import 'package:broking/model/ddd/login_type_data.dart';


class LoginTypeModel {

  List<LoginTypeData>? responsedata;
  String message;
  String status;

  LoginTypeModel(
      {required this.responsedata,

        required this.message,
        required this.status});

  factory LoginTypeModel.fromJson(Map<String, dynamic> json) {
    return LoginTypeModel(
      responsedata: json['responsedata'] != null
          ? (json['responsedata'] as List)
          .map((i) => LoginTypeData.fromJson(i))
          .toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (responsedata != null && responsedata!.isNotEmpty) {
      data['responsedata'] = responsedata?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
