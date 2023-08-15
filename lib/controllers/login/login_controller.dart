import 'package:broking/model/ddd/login_type_data.dart';
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
  final emailController = TextEditingController();
  RxList<LoginTypeData> typeList = <LoginTypeData>[].obs;
  late final Rx<LoginTypeData> selectTypeValue = typeList.first.obs;
  final loginType = "0".obs;
  final isLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    callLoginTypeApi();
  }

  void callLoginApi() async {
    if (userNameController.text.isEmpty) {
      Common.showToast("Please enter user name");
      return;
    }
    if (passwordController.text.isEmpty) {
      Common.showToast("Please enter password");
      return;
    }
    showLoader();
    try {
      final response = await apiServices.loginApi(
        userNameController.text.toString(),
        passwordController.text.toString(),
        selectTypeValue.value.id,
      );
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.loginData.isNotEmpty) {
          appPreferences.saveUserId(response.loginData[0].id);
          appPreferences.saveEmail(response.loginData[0].email);
          appPreferences.saveUserName(response.loginData[0].userName);
          appPreferences.saveUserPhone(response.loginData[0].phone);
          appPreferences.saveOfficeId(response.loginData[0].officeId);
          appPreferences.saveLoggedIn(true);
          DashboardPage.start();
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callLoginTypeApi() async {
    isLoader.value = true;
    try {
      final response = await apiServices.loginType();
      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        typeList.value = response.responsedata ?? [];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void forgotApi() async {
    if (emailController.text.isEmpty) {
      Common.showToast("Please enter user name");
      return;
    }
    showLoader();
    try {
      final response = await apiServices.forgotApi(emailController.text.toString());
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.status.isNotEmpty) {
          DashboardPage.start();
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
