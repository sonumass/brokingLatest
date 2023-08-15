import 'package:broking/model/prospects/viewprospects/Responsedata.dart';
import 'package:broking/ui/module/prospects/widget/edit_contact_parson.dart';
import 'package:broking/ui/module/prospects/widget/policy_perticulers_card.dart';
import 'package:broking/ui/module/prospects/widget/edit_prospects_detail_card.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/prospect_detail_controller.dart';
import '../../../controllers/prospects/prospect_list_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';

class ProspectsDetailPage extends AppPageWithAppBar {
  static const String routeName = "/ProspectsDetailPage";
  final controller = Get.find<ProspectListController>();
  final controllerProspectDetail = Get.put(ProspectDetailCardController());
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final items = <String>[];
  ProspectsDetailPage({super.key});
  @override
  double? get toolbarHeight => 0;
  ProspectViewData get prospectViewData => arguments["prospectViewData"];

  static Future<bool?> start<bool>(ProspectViewData prospectViewData) {
    return navigateTo<bool>(currentPageTitle: "Prospects", routeName,arguments: {"prospectViewData":prospectViewData});
  }
  @override
  Widget get body {
    controllerProspectDetail.prospectViewData=arguments["prospectViewData"];
    controllerProspectDetail.inputDat(prospectViewData);
    return Scaffold(
      backgroundColor: Palette.backgroundBg,

      body: Container(decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/background.png"),
            fit: BoxFit.cover,
          ),
        ),child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: SizedBox(height: 10,),
            ),
            SliverToBoxAdapter(
              child: appBarWidget,
            ),
            SliverToBoxAdapter(
              child: myText,
            ),
            controllerProspectDetail.prospectViewData!=null?SliverToBoxAdapter(
              child: ProspectDetailCard(prospectData:controllerProspectDetail.prospectViewData!.prospectDetails!),
            ):const SizedBox.shrink(),
            controllerProspectDetail.prospectViewData!=null?SliverToBoxAdapter(
              child: ContactCard(contactperson:controllerProspectDetail.prospectViewData!.contactperson),
            ):const SizedBox.shrink(),
            controllerProspectDetail.prospectViewData!=null?SliverToBoxAdapter(
              child: PolicyCard(policies:controllerProspectDetail.prospectViewData!.policies),
            ):const SizedBox.shrink(),
            /*SliverToBoxAdapter(
                child: QutationCard(),
            ),*/
          ],
        ),),);

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
            "Edit",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorWhite,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Text(
            "Prospect",
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {},
        controller: controller.searchViewController,
        cursorColor: Palette.appColor,
        decoration: const InputDecoration(
            labelText: "Search Prospects Name",
            hintText: "Prospects Name",
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

  Widget get prospectList {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const Text("Data");
        /*return ListTile(
          title: ProspectCard(),
        );*/
      },
    );
  }
}
