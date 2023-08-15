import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/network/apiservices/login_api_service.dart';
import '../../data/network/apiservices/prospect_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../ui/module/dashboard/dashboard_page.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ProspectListCardController extends BaseController {
  final isCollapse=false.obs;
  final apiServices = Get.find<ProspectApiServices>();
  void callSentMailApi({prospectId,email,phone,type}) async {
    showLoader();
    final response = await apiServices.sentMailApi("rambajpai@3ditec.com","16142","email","908764567");
   hideLoader();
    if (response == null) Common.showToast("Server Error!");
    Common.showToast(response!=null?response.message:"Something went wrong!");

  }
}