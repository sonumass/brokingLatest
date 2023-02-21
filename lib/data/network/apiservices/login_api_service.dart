
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../constants/Constant.dart';
import '../../../model/login/Login_data_model.dart';
import '../../../model/login/login_input_model.dart';
import '../dio_client.dart';

class LoginApiServices extends DioClient {
  final client = DioClient.client;

  Future<LoginDataModel?> loginApi(String username, String password,String type) async {
    String inputData = jsonEncode(
        LoginInputModel(username: username, password: password, type: type));

    debugPrint('inputData: $inputData');
    LoginDataModel? loginModel;
    try {
      final response = await client.post(
        "${Constant.baseUrl}/broking/api/bdm_login",
        data: inputData,
      );
      if (kDebugMode) {
        print('inputData: $inputData');
        print('outPut: ${response.data}');
      }
      try {
        loginModel = LoginDataModel.fromJson(response.data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return loginModel;
  }

}
