
import 'dart:convert';
import 'package:broking/model/login/loginresponse/LoginResponseData.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../model/common_model.dart';
import '../../../model/ddd/LoginTypeModel.dart';
import '../../../model/login/Login_data_model.dart';
import '../../../model/login/login_input_model.dart';
import '../dio_client.dart';
import 'base_api_Service.dart';

class LoginApiServices extends DioClient {
  final client = DioClient.client;
  Future<LoginResponseDataModel?> loginApi(
      String username, String password, String type) async {
    String inputData = jsonEncode(
        LoginInputModel(username: username, password: password, type: type));

    debugPrint('inputData: $inputData');
    LoginResponseDataModel? loginModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/bdm_login",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = LoginResponseDataModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
  Future<LoginTypeModel?> loginType() async {
    LoginTypeModel? loginTypeModel;
    final response = await client.post(
        "${Constant.baseUrl}/broking/api/login_type",
        data: jsonEncode(null),
        options: getBroKingHeader());
    loginTypeModel = LoginTypeModel.fromJson(jsonDecode(response.data));
    return loginTypeModel;
  }
  Future<CommonModel?> forgotApi(
      String email) async {
    String inputData = jsonEncode({"email":email});
    debugPrint('inputData: $inputData');
    CommonModel? loginModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/forget_otp",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = CommonModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
  Future<CommonModel?> otpVerifyApi(
      String email,String otp) async {
    String inputData = jsonEncode({"email":email,"otp":otp});
    debugPrint('inputData: $inputData');
    CommonModel? loginModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/forget_otp_verify",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = CommonModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
  Future<CommonModel?>resetPasswordApi(
      String email,String password) async {
    String inputData = jsonEncode({"email":email,"password":password});
    debugPrint('inputData: $inputData');
    CommonModel? loginModel;
    try {
      final response = await client.post(
          "${Constant.baseUrl}/broking/api/reset_password",
          data: inputData,
          options: getBroKingHeader());
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = CommonModel.fromJson(jsonDecode(response.data));
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }
}
