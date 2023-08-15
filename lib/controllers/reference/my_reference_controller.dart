import 'package:broking/data/network/apiservices/prospect_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../model/ddd/LoginTypeModel.dart';
import '../../model/ddd/login_type_data.dart';
import '../../model/prospects/prospectinput/contect_person_item_input.dart';
import '../../model/prospects/prospectinput/policy_item_input.dart';
import '../../model/prospects/prospectinput/prospect_detail_input.dart';
import '../../model/prospects/viewprospects/Responsedata.dart';
import '../../model/reminder/Reminder_count_model.dart';
import '../../model/reminder/Responsedata.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ReferenceController extends BaseController {
  final apiServices = Get.put(ProspectApiServices());
  final appPreferences = Get.find<AppPreferences>();
  RxList<LoginTypeData> premiumPotential = <LoginTypeData>[].obs;
  RxList<LoginTypeData> policyType = <LoginTypeData>[].obs;
  late final Rx<LoginTypeData> policyValue = policyType.first.obs;
  late final Rx<LoginTypeData> premiumPotentialValue =
      premiumPotential.first.obs;
  final isLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    callReferenceApi();
  }

  void callReferenceApi({type}) async {
    isLoader.value = true;
    final response = await apiServices.referenceData(
        appPreferences.email, appPreferences.userId);
    isLoader.value = false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      premiumPotential.value = response.responsedata?.premiumPotential ?? [];
      policyType.value = response.responsedata?.policyType ?? [];
      // policyValue.value=premiumPotential.first;
      //premiumPotentialValue.value=premiumPotential.first;
    }
  }
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  void sentReference(
      String referenceName,
      String mobile,
      String email,
      String searchProspect,
      String contactPersonName,
      String premiumPotentialId,
      String policyTypeId) async {
    if (referenceName.isEmpty) {
      Common.showToast("Please enter name");
      return;
    }
    if (mobile.isEmpty) {
      Common.showToast("Please enter mobile");
      return;
    }
    if (email.isEmpty) {
      Common.showToast("Please enter email");
      return;
    }
    if (!isEmail(email)) {
      Common.showToast("Please enter valid email");
      return;
    }
    if (searchProspect.isEmpty) {
      Common.showToast("Please enter prospect");
      return;
    }
    if (contactPersonName.isEmpty) {
      Common.showToast("Please enter Contact Person Name");
      return;
    }

    showLoader();
    final response = await apiServices.sentReference(
        appPreferences.email,
        appPreferences.userId,
        referenceName,
        mobile,
        email,
        searchProspect,
        contactPersonName,
        premiumPotentialId,
        policyTypeId);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    Common.showToast(response?.message ?? "Something went wrong");
  }
}
