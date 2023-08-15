import 'package:broking/ui/module/prospects/prospect_list.dart';
import 'package:get/get.dart';

import '../../ui/module/prospects/contact_card_add_more.dart';
import '../../ui/module/prospects/create_prospects.dart';
import '../../ui/module/prospects/policy_card_add_more.dart';
import '../../ui/module/prospects/prodpect_deatil_card_add_more.dart';
import '../../ui/module/prospects/prospects_details.dart';
import '../../ui/module/prospects/prospects_preview_details.dart';
import '../../ui/module/renewable/renewable_list.dart';

class ProspectRoutes {
  ProspectRoutes._();

  static List<GetPage> get routes => [
    GetPage(name: ProspectsListPage.routeName, page: () => ProspectsListPage()),
    GetPage(name: ProspectsDetailPage.routeName, page: () => ProspectsDetailPage()),
    GetPage(name: ContactAddMorePage.routeName, page: () => ContactAddMorePage()),
    GetPage(name: PolicyAddMorePage.routeName, page: () => PolicyAddMorePage()),
    GetPage(name: ProspectsCreatePage.routeName, page: () => ProspectsCreatePage()),
    GetPage(name: CreateAddProspectPage.routeName, page: () => CreateAddProspectPage()),
    GetPage(name: ProspectsPreviewDetailPage.routeName, page: () => ProspectsPreviewDetailPage()),
    GetPage(name: RenewablePage.routeName, page: () => RenewablePage()),


  ];
}
