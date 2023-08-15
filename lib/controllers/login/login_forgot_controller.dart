import 'package:broking/ui/module/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/network/apiservices/login_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../ui/module/login/set_password_page.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ForgotOtpController extends BaseController {
  final apiServices = Get.put(LoginApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final emailController = TextEditingController();

  final isVerified = false.obs;
  final code = "".obs;
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
        if (response.message.isNotEmpty) {
          //DashboardPage.start();
          isVerified.value=true;
         // if(isVerified.value)ChangePasswordPage.start();
          Common.showToast(response?.message ?? "Something went wrong!");
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void otpVerifyApi(String otp) async {
    if (emailController.text.isEmpty) {
      Common.showToast("Please enter user name");
      return;
    }
    showLoader();
    try {
      final response = await apiServices.otpVerifyApi(emailController.text.toString(),otp);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.message.isNotEmpty) {
          ChangePasswordPage.start(emailController.text.toString());
          Common.showToast(response?.message ?? "Something went wrong!");
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void resetPasswordApi(String email,String password) async {
    if (password.isEmpty) {
      Common.showToast("Please enter password");
      return;
    }
    showLoader();
    try {
      final response = await apiServices.resetPasswordApi(email,password);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.message.isNotEmpty) {
          LoginPage.start();
          Common.showToast(response.message);
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
