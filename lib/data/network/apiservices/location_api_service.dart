
import 'dart:convert';
import 'package:broking/model/ddd/login_type_data.dart';
import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/model/prospects/prospectinput/prospect_detail_input.dart';
import 'package:broking/model/reminder/alarmmodel/Alarm_model.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../model/common_model.dart';
import '../../../model/ddd/LocationTypeModel.dart';
import '../../../model/ddd/LoginTypeModel.dart';
import '../../../model/login/Login_data_model.dart';
import '../../../model/login/login_input_model.dart';
import '../../../model/prospects/prospectinput/policy_item_input.dart';
import '../../../model/prospects/viewprospects/Prospects_data_model.dart';
import '../../../model/reminder/Reminder_count_model.dart';
import '../../../model/reminder/detailList/Reminder_detail_list.dart';
import '../dio_client.dart';
import 'base_api_Service.dart';

class LocationApiServices extends DioClient {
  final client = DioClient.client;
  Future<LocationTypeModel?> getLocation() async {
    String inputData = jsonEncode({});

    debugPrint('inputData: $inputData');
    LocationTypeModel? locationTypeModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/location",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        locationTypeModel = LocationTypeModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return locationTypeModel;
  }

}
