import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/dialog/loader.dart';
import 'package:broking/ui/module/prospects/widget/prospects__list_card.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/prospect_list_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';
import 'create_prospects.dart';

class ProspectsListPage extends AppPageWithAppBar {
  static const String routeName = "/ProspectsListPage";
  final controller = Get.put(ProspectListController());
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final items = <String>[];

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(currentPageTitle: "Prospects", routeName);
  }

  ProspectsListPage({super.key});

  @override // TODO: implement appBar
  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {
            ProspectsCreatePage.start();
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
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : Scaffold(
            backgroundColor: Palette.backgroundBg,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/png/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: CustomScrollView(
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
                 /* SliverToBoxAdapter(child: signedAndUnSigned,),*/
                  if (controller.dataList.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ProspectCard(
                              prospectViewData: controller.dataList[index]);
                        },
                        childCount:
                            controller.dataList.length, // 1000 list items
                      ),
                    ),
                ],
              ),
            )));
  }

  Widget get appBarWidget {
    return Column(
      children: [
        const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: SizedBox(
            height: 50,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset(
                    width: 25, height: 25, 'assets/png/back_bar.svg'),
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
            )
          ],
        )
      ],
    );
  }

  Widget get myText {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 5),
              child: Text(
                "My",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 0, bottom: 10),
              child: Text(
                "Prospects",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            ProspectsCreatePage.start();
          },
          child: Card(
            margin: const EdgeInsets.only(right: 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(width: 0.0, color: Colors.transparent)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Add Prospect",
                style: TextStyles.headingTexStyle(
                  color: Palette.appBar,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get searchView {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage("assets/png/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: TextField(
        onChanged: (value) {
          controller.filterSearchResults(value);
        },
        controller: controller.searchViewController,
        cursorColor: Palette.appColor,
        decoration: const InputDecoration(
            fillColor: Palette.kColorWhite,
            hintText: "Search",
            focusColor: Palette.kColorWhite,
            hintMaxLines: 1,
            contentPadding: EdgeInsets.all(5),
            prefixIcon: Icon(
              Icons.search,
              color: Palette.appColor,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)))),
      ),
    );
  }
  Widget get signedAndUnSigned{
    return Container(height:50,width:screenWidget,color: MyColors.kColorWhite,child: Row(
      children: [
        SizedBox(height: 40,width: screenWidget/2,child: Card(elevation:30,color:MyColors.kColorGreenDark,child: const Center(child: Text("Signed",style: TextStyle(color: MyColors.kColorWhite)),)),),

        SizedBox(height: 40,width: screenWidget/2,child: const Card(elevation:30,color:MyColors.kColorWhite,child: Center(child: Text("Unsigned",style: TextStyle(color: MyColors.colorTextGrey),),)),),

      ],
    ),);
  }
}
