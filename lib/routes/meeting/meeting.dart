import 'package:broking/ui/module/meetings/dashboard_my_meeting_prospect.dart';
import 'package:broking/ui/module/meetings/meeting_list.dart';
import 'package:get/get.dart';

import '../../ui/module/meetings/create_meeting.dart';
import '../../ui/module/meetings/meeting_dashboard.dart';
import '../../ui/module/meetings/my_meeting_list.dart';

class MeetingRoutes {
  MeetingRoutes._();

  static List<GetPage> get routes => [
    GetPage(name: MeetingListPage.routeName, page: () => MeetingListPage()),
    GetPage(name: CreateMeeting.routeName, page: () => CreateMeeting()),
    GetPage(name: MeetingDashboard.routeName, page: () => MeetingDashboard()),
    GetPage(name: MyMeetingListPage.routeName, page: () => MyMeetingListPage()),
    GetPage(name: MyMeetingProspectList.routeName, page: () => MyMeetingProspectList()),


  ];
}
