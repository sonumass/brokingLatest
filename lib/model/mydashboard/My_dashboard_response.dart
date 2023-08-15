import 'my_dashboard_data.dart';

class MyDashboardResponse {
  MyDashboardResponse({
    required this.responsedata,
    required this.message,
    required this.status,
  });

  MyDashboardResponse.fromJson(dynamic json) {
    responsedata = json['responsedata'] != null
        ? MyDashboardData.fromJson(json['responsedata'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  MyDashboardData? responsedata;
  String message = "";
  String status = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (responsedata != null) {
      map['responsedata'] = responsedata!.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}
