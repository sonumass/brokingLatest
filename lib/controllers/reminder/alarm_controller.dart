import 'package:get/get.dart';
import '../../data/network/apiservices/alarm_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class AlarmController extends BaseController {
  final apiServices = Get.put(AlarmApiServices());
  final appPreferences = Get.find<AppPreferences>();

  @override
  void onInit() {
    super.onInit();
    callAlarmApi();
  }

  void callAlarmApi() async {
    final response = await apiServices.alarmApi(
        appPreferences.email, appPreferences.userId);
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      if (response.responsedata.isNotEmpty) {
        for (var element in response.responsedata) {
           var hr=element.time.split(":")[0];
           var min=element.time.split(":")[1];
          Common.setAlarm(int.parse(hr),int.parse(min), element.meetingwith);
        }
      }
    }
  }
}