import 'ReminderDataList.dart';

class ReminderDataList{
  List<DataList> data=[];
  ReminderDataList({
    required this.data});
  ReminderDataList.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(DataList.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }

}