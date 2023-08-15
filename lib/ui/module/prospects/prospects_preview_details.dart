import 'package:broking/ui/module/prospects/preview/contact_parson.dart';
import 'package:broking/ui/module/prospects/preview/policy_preview_perticulers_card.dart';
import 'package:broking/ui/module/prospects/preview/prospects_detail_card.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/contact_add_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/primary_elevated_button.dart';

class ProspectsPreviewDetailPage extends AppPageWithAppBar {
  static const String routeName = "/ProspectsPreviewDetailPage";

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final items = <String>[];
  ProspectsPreviewDetailPage({super.key});

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(currentPageTitle: "Prospects", routeName,);
  }
  final controller=Get.find<ContactAddController>();

  @override
  Widget get body {
    return Scaffold(
      backgroundColor: Palette.backgroundBg,
        body: SafeArea(
          child: Container(decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/png/background.png"),
              fit: BoxFit.cover,
            ),
          ),child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: SvgPicture.asset(width:25,height: 25,'assets/png/back_bar.svg'),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 10,),
                      ),
                      if(controller.prospectDetailInput.prospectName.isNotEmpty)SliverToBoxAdapter(
                        child: ProspectDetailPreviewCard(prospectData:controller.prospectDetailInput),
                      ),
                      if(controller.contactInputDataList.isNotEmpty)SliverToBoxAdapter(
                        child: ContactPreviewCard(contactperson:controller.contactInputDataList),
                      ),
                      if(controller.policyInputDataList.isNotEmpty)SliverToBoxAdapter(
                        child: PolicyPreviewCard(policies:controller.policyInputDataList),
                      ),
                      SliverToBoxAdapter(
                        child: uploadButton(),
                      ),
                      /*SliverToBoxAdapter(
                          child: QutationCard(),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),),
        ));

  }
  Widget uploadButton() {
    return SizedBox(height: 60,width: screenWidget/2.5,child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn("Add Prospect", () {
          //loginController.callLoginApi(type: "5")
          //ProspectsPreviewDetailPage.start();
          controller.createProspectApi();
        }, borderRadius: 10.0),
      ),
    ),);
  }
  Widget get searchView {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {},
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
        return Text("Data");
        /*return ListTile(
          title: ProspectCard(),
        );*/
      },
    );
  }
}
