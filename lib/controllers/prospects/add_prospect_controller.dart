import 'package:broking/controllers/prospects/contact_add_controller.dart';
import 'package:get/get.dart';
import '../../data/network/apiservices/prospect_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ProspectListCardController extends BaseController {
  final isCollapse=false.obs;
  final apiServices = Get.find<ProspectApiServices>();
  final controller =Get.find<ContactAddController>();
  final appPreferences = Get.find<AppPreferences>();


}