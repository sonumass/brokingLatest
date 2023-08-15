import 'package:broking/ui/dialog/loader.dart';
import 'package:broking/ui/module/meetings/widget/meeting_card.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/meeting/meeting_list_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';
import 'meeting_dashboard.dart';

class MyMeetingListPage extends AppPageWithAppBar {
  static const String routeName = "/MyMeetingListPage";
  final controller=Get.put(MeetingController());
  

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(currentPageTitle: "Meeting", routeName,);
  }

  MyMeetingListPage({super.key});
  @override
  double? get toolbarHeight => 0;
  @override // TODO: implement appBar
  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {

            //CreateMeeting.start(arguments["prospectId"],arguments["name"],arguments["address"]);
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: const [
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: Palette.kColorWhite,
                    )),
              ],
            ),
          ),
        )
      ];

  @override
  Widget get body {
    controller.callMeetingApi("","0");
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : Scaffold(
        backgroundColor: Palette.backgroundBg,
            body: Container(decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/background.png"),
                fit: BoxFit.cover,
              ),
            ),child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: appBarWidget,
                ),
                SliverToBoxAdapter(
                  child: myText,
                ),
                SliverToBoxAdapter(
                  child: searchView,
                ),

                if (controller.meetingList.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return MeetingListCard(
                            meetingData:
                            controller.meetingList[index],isFirstCardOpen:index==0?true:false);
                      },
                      childCount:
                      controller.meetingList.length, // 1000 list items
                    ),
                  ),
              ],
            ),)));
  }
  Widget get appBarWidget{
    return Column(children: [const PreferredSize(
      preferredSize: Size.fromHeight(50.0),child: SizedBox(height: 50,),),Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: SvgPicture.asset(width:25,height: 25,'assets/png/back_bar.svg'),
      ),
    ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 50,
          height: 50,
          child: SvgPicture.network("https://3ditec.co.in/broking/assets/images/crownlogo.svg"),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(
              left: 0, right: 15, top: 8, bottom: 8),
          child: Stack(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: SvgPicture.asset('assets/png/ic_notification.svg'),
              ),
            ],
          ),
        ),
      )],)],);

  }

  Widget get myText {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Text(
            "My",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorWhite,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Text(
            "Meeting(s)",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorWhite,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        )
      ],
    );
  }
  Widget get searchView {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 20,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: TextField(
        onChanged: (value) {
          controller.filterSearchResults(value,"");
        },
        cursorColor: Palette.appColor,
        decoration: const InputDecoration(
            fillColor: Palette.kColorWhite,
            hintText: "Prospects Name",
            focusColor: Palette.kColorWhite,
            hintMaxLines: 1,
            prefixIcon: Icon(
              Icons.search,
              color: Palette.appColor,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
      ),
    );
  }
}
