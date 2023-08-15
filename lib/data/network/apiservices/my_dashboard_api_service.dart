
import 'dart:convert';
import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/model/prospects/prospectinput/prospect_detail_input.dart';
import 'package:broking/model/reminder/alarmmodel/Alarm_model.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../model/common_model.dart';
import '../../../model/ddd/LoginTypeModel.dart';
import '../../../model/login/Login_data_model.dart';
import '../../../model/login/login_input_model.dart';
import '../../../model/mydashboard/My_dashboard_response.dart';
import '../../../model/prospects/prospectinput/policy_item_input.dart';
import '../../../model/prospects/viewprospects/Prospects_data_model.dart';
import '../../../model/reminder/Reminder_count_model.dart';
import '../../../model/reminder/detailList/Reminder_detail_list.dart';
import '../dio_client.dart';
import 'base_api_Service.dart';

class MyDashboardApiServices extends DioClient {
  final client = DioClient.client;
  Future<MyDashboardResponse?> dashboardApi(String email,String userId) async {
    String inputData = jsonEncode({"useremail":email,"user_id":userId});

    debugPrint('inputData: $inputData');
    MyDashboardResponse? myDashboardResponse;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/prospectstatuscount",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        myDashboardResponse = MyDashboardResponse.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return myDashboardResponse;
  }

}
