import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/network/apiservices/login_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../ui/module/dashboard/dashboard_page.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class LoginController extends BaseController {
  final apiServices = Get.put(LoginApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final loginType="0".obs;
  final isLoader = false.obs;
  void callLoginApi({type}) async {
    if (userNameController.text.isEmpty) {
      Common.showToast("Please enter email");
      return;
    }
    showLoader();
    try {
      final response = await apiServices.loginApi(
        userNameController.text.toString(),passwordController.text.toString(),type
        ,
      );
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null &&
          response.response == "Success" &&
          response.data != null) {
       /* loginModel = response.loginData!;
        appPreferences.saveEmail(loginModel.email);
        appPreferences.saveUserName(loginModel.name);
        appPreferences.saveUserId(loginModel.id.toString());
        appPreferences.saveUserImage(loginModel.img);
        appPreferences.saveMobile(mobile ?? "");
        appPreferences.saveLoggedIn(true);
        appPreferences.saveReferralCode(loginModel.reffralCode);
        appPreferences.saveUserExit(loginModel.userExist);*/
        DashboardPage.start();

      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}