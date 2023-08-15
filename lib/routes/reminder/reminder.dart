import 'package:broking/ui/module/prospects/prospect_list.dart';
import 'package:get/get.dart';

import '../../ui/module/prospects/contact_card_add_more.dart';
import '../../ui/module/prospects/create_prospects.dart';
import '../../ui/module/prospects/policy_card_add_more.dart';
import '../../ui/module/prospects/prodpect_deatil_card_add_more.dart';
import '../../ui/module/prospects/prospects_details.dart';
import '../../ui/module/prospects/prospects_preview_details.dart';
import '../../ui/module/reference/my_reference.dart';
import '../../ui/module/reminder/reminder_list.dart';
import '../../ui/module/reminder/reminder_list_detail_list.dart';
import '../../ui/module/renewable/renewable_list.dart';

class ReminderRoutes {
  ReminderRoutes._();

  static List<GetPage> get routes => [
    GetPage(name: ReminderPage.routeName, page: () => ReminderPage()),
    GetPage(name: ReminderDetailListPage.routeName, page: () => ReminderDetailListPage()),
    GetPage(name: ReferencePage.routeName, page: () => ReferencePage()),


  ];
}
