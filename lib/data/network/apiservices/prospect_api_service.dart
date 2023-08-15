
import 'dart:convert';
import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/model/prospects/prospectinput/prospect_detail_input.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../model/common_model.dart';
import '../../../model/ddd/LoginTypeModel.dart';
import '../../../model/login/Login_data_model.dart';
import '../../../model/login/login_input_model.dart';
import '../../../model/prospectdata/Prospect_data.dart';
import '../../../model/prospects/prospectinput/policy_item_input.dart';
import '../../../model/prospects/viewprospects/Prospects_data_model.dart';
import '../../../model/reference/Reference_model_response.dart';
import '../../../model/reminder/Reminder_count_model.dart';
import '../../../model/reminder/detailList/Reminder_detail_list.dart';
import '../dio_client.dart';
import 'base_api_Service.dart';

class ProspectApiServices extends DioClient {
  final client = DioClient.client;
  Future<ProspectsDataModel?> prospectListApi(String email,String userId,String officeId) async {
    String inputData = jsonEncode({"email":email,"user_id":userId,"office_id":officeId});

    debugPrint('inputData: $inputData');
    ProspectsDataModel? prospectsDataModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/view_prospects",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        prospectsDataModel = ProspectsDataModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return prospectsDataModel;
  }
  Future<ProspectData?> prospectData(String email) async {
    String inputData = jsonEncode({"email":email,});

    debugPrint('inputData: $inputData');
    ProspectData? prospectData;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/prospectdata",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        prospectData = ProspectData.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return prospectData;
  }
  Future<ProspectsDataModel?> renewableListApi(String email,String userId,String officeId) async {
    String inputData = jsonEncode({"email":email,"user_id":userId,"office_id":officeId});

    debugPrint('inputData: $inputData');
    ProspectsDataModel? prospectsDataModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/policy_renewals",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        prospectsDataModel = ProspectsDataModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return prospectsDataModel;
  }
  Future<ReminderCountModel?> reminderCount(String email,String userId,) async {
    String inputData = jsonEncode({"email":email,"user_id":userId});

    debugPrint('inputData: $inputData');
    ReminderCountModel? reminderCountModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/remindercount",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        reminderCountModel = ReminderCountModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return reminderCountModel;
  }
  Future<ReminderDetailListModel?> reminderDetailList(String email,String userId,String reminderType) async {
    String inputData = jsonEncode({"email":email,"user_id":userId,"reminderType":reminderType});

    debugPrint('inputData: $inputData');
    ReminderDetailListModel? reminderDetailList;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/reminderList",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        reminderDetailList = ReminderDetailListModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return reminderDetailList;
  }
  Future<ReferenceModelResponse?> referenceData(String email,String userId,) async {
    String inputData = jsonEncode({"email":email,"user_id":userId});

    debugPrint('inputData: $inputData');
    ReferenceModelResponse? reminderCountModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/refrencedata",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        reminderCountModel = ReferenceModelResponse.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return reminderCountModel;
  }
  Future<CommonModel?> sentReference(String userEmail,String userId,String referenceName,String mobile,String email,String searchProspect,String contactPersonName,String premiumPotentialId,String policyTypeId) async {
    String inputData = jsonEncode({"useremail":userEmail,"user_id":userId,"referenceName":referenceName,
      "mobile":mobile,"email":email,"searchProspect":searchProspect,"contactPersonName":contactPersonName,"premiumPotentialId":premiumPotentialId,"policyTypeId":policyTypeId});

    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/add_reference",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        commonModel = CommonModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }
  Future<CommonModel?> sentMailApi(String email,String prospectId,String type,String phone) async {
    String inputData = jsonEncode({"email":email,
      "prospectid":prospectId,"phone":phone,"type":"type",});

    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/sentmail",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        commonModel = CommonModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }
  Future<CommonModel?> addProspectApi(ProspectDetailInput prospectDetailInput,List<ContactItemInput> contactList,List<PolicyItemInput> policyList) async {
    var inputData = jsonEncode({
      "prospectDetail":prospectDetailInput,"contact":contactList,"Policy":policyList});

    debugPrint("${prospectDetailInput.toJson()}");
    debugPrint("${contactList.toList()}");
    debugPrint("${policyList.toList()}");
    CommonModel? commonModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/add_prospects",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        commonModel = CommonModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }
  Future<CommonModel?> editProspectApi(ProspectDetailInput prospectDetailInput,List<ContactItemInput> contactList,List<PolicyItemInput> policyList) async {
    var inputData = {"prospect_details":prospectDetailInput,"contact":contactList,"Policy":policyList};

    debugPrint('inputData: $inputData');
    CommonModel? commonModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/edit_prospects",
          data: jsonEncode(inputData),
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        final data =jsonDecode(response.data);
        commonModel = CommonModel.fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return commonModel;
  }

}
