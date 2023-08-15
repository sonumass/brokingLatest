import 'dart:convert';
import 'package:broking/model/common_model.dart';
import 'package:broking/model/meeting/Meeting_list.dart';
import 'package:broking/model/meeting/Meeting_prospect_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../model/meeting/cretaemeeting/Meeting_data_model.dart';
import '../../../model/meeting/meetingList/Meeting_list_response.dart';
import '../../../model/meeting/meeting_input_type.dart';
import '../dio_client.dart';
import 'base_api_Service.dart';

class MeetingApiServices extends DioClient {
  final client = DioClient.client;
  Future<MeetingProspectResponse?> meetingProspect(String email, String userId,String officeId) async {
    String inputData = jsonEncode({"email": email, "user_id": userId,"office_id":officeId});

    debugPrint('inputData: $inputData');
    MeetingProspectResponse? meetingProspect;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/viewprospectsmeeting",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        meetingProspect = MeetingProspectResponse.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return meetingProspect;
  }
  Future<MeetingListResponse?> meetingListApi(String email, String userId,String type,{prospectId}) async {
    String inputData = jsonEncode({"email": email, "user_id": userId,"type":type,"prospectId":prospectId});

    debugPrint('inputData: $inputData');
    MeetingListResponse? meetingList;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/prospectmeetingdata",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        meetingList = MeetingListResponse.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return meetingList;
  }
  Future<MeetingDataModel?> getMeetingDataApi(String email, String prospectId,String userid) async {

    String inputData = jsonEncode({"userid": userid, "prospectId": prospectId});
    Options options = Options();
    Map<String, dynamic> headers = Map();
    headers['API-KEY'] = r'BR!D$@!@#$';
    headers['email'] = email;
    options.headers = headers;

    debugPrint('inputData: $inputData');
    MeetingDataModel? meetingList;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/meetingdata",
          data: inputData,
          options: options);
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        meetingList = MeetingDataModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return meetingList;
  }

  Future<CommonModel?> createMeetingApi(MeetingInputModel data,String userId,
      {latitude,longitude}) async {
    String inputData = jsonEncode({"data":data,
      "latitude":latitude,
      "longitude":longitude
    });

    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/add_meetings",
          data: inputData,
          options: getBroKingHeader(userId:userId));
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        commonModel = CommonModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }
}
