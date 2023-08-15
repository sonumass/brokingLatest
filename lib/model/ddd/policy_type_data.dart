import 'package:get/get.dart';

class PolicyTypeData {
  String id;
  String type;
  RxBool isCheck;

  PolicyTypeData({required this.id, required this.type,required this.isCheck});

  factory PolicyTypeData.fromJson(Map<String, dynamic> json) {
    return PolicyTypeData(
      id: json['id'] ?? "",
      type: json['type'] ?? "",
      isCheck: json['isCheck'] ?? false.obs,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['isCheck'] = isCheck;
    return data;
  }
}
