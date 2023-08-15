import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/ui/module/meetings/meeting_dashboard.dart';
import 'package:broking/ui/module/prospects/prospects_details.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controllers/prospects/prospect_list_card_controller.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../model/prospects/viewprospects/Contactperson.dart';
import '../../../../model/prospects/viewprospects/Policies.dart';
import '../../../../model/prospects/viewprospects/Responsedata.dart';
import '../../../commonWidget/name_icon.dart';
import '../../../commonWidget/text_style.dart';
import '../../meetings/meeting_list.dart';

class ProspectCard extends BaseStateLessWidget {
  ProspectCard({super.key, required this.prospectViewData});

  final appPreferences = Get.find<AppPreferences>();
  final ProspectViewData prospectViewData;
  final controller = Get.put(ProspectListCardController());
  final isCollapse = false.obs;

  @override
  Widget build(BuildContext context) {
    return card;
  }

  Widget get card {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Palette.appBar,
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),child: Column(
        children: [cardHeader, visibleView,Align(alignment: Alignment.centerRight,child: InkWell(onTap:() {isCollapse.toggle();},child: collapseIcon,),), bottomIcons],
      ),
    );
  }

  Widget get cardHeader {
    return  InkWell(
      onTap: () {
        isCollapse.toggle();
      },
      child: Obx(()=>isCollapse.value?Padding(
        padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.person,
                    color: Palette.kColorBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: SizedBox(
                    width: screenWidget/1.9,
                    child: Text(
                        prospectViewData.prospectDetails?.prospectName ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.headingTexStyle(


                            color: Palette.kColorBlack,
                            fontFamily: "assets/font/Oswald-Bold.ttf")),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                ProspectsDetailPage.start(prospectViewData);
              },
              child: const Icon(
                Icons.edit_note,
                size: 38,
                color: Palette.appColor,
              ),
            )


          ],
        ),
      ):const SizedBox.shrink()),
    );
  }

  Widget get visibleView {
    return Padding(padding: const EdgeInsets.only(top: 10),child: Container(
        color: Palette.kColorWhite,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => !isCollapse.value?const SizedBox.shrink():Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Prospects Detail",
                      style: TextStyles.headingTexStyle(
                        color: Palette.kColorBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      )),

                ],
              )),
              rowColumn("Prospect's Name",
                  prospectViewData.prospectDetails?.prospectName ?? ""),
              rowColumn(
                  "City", prospectViewData.prospectDetails?.cityName ?? ""),
              rowColumn("Premium Potential",
                  prospectViewData.prospectDetails?.premiumPotential ?? ""),
              rowColumn("Industries Type", prospectViewData.prospectDetails?.industryType ?? ""),
              dataVisible()
            ],
          ),
        )),);
  }

  Widget rowColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.prospectCardTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
              width: screenWidget / 2,
              child: Text(
                value,
                style: TextStyles.headingTexStyle(
                  color: Palette.prospectCardTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Montserrat',
                ),
              ))
        ],
      ),
    );
  }

  Widget get collapseIcon {
    return Padding(padding: const EdgeInsets.only(right: 20,bottom: 10),child: Obx(() => !isCollapse.value
        ?  SvgPicture.asset('assets/png/down_arrow.svg')
        : SvgPicture.asset('assets/png/up_arrow.svg')),);
  }

  Widget get bottomIcons {
    return Container(decoration: const BoxDecoration(
      color: Palette.lightColor,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
    ),child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            actionPerform(Get.context!, "msg");
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipOval(
              child: Container(
                color: Palette.iconbgColor,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.sms,
                    color: MyColors.kColorWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            actionPerform(Get.context!, "email");
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipOval(
              child: Container(
                color: Palette.iconbgColor,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.email_rounded,
                    color: MyColors.kColorWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            actionPerform(Get.context!,
                "call"); /*Uri.parse("whatsapp://send?phone=+919087898765&text=hello");*/
          },
          child: Padding(
            padding:  const EdgeInsets.all(10),
            child: ClipOval(
              child: Container(
                color:  Palette.iconbgColor,
                child:  const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.call,
                    color: MyColors.kColorWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            MeetingDashboard.start(
                prospectViewData.prospectDetails?.prospectId ?? "",prospectViewData.prospectDetails?.prospectName??"",prospectViewData.prospectDetails?.adddress??"");
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipOval(
              child: Container(
                color:  Palette.iconbgColor,
                child: const Padding(
                  padding:
                  EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.supervised_user_circle_rounded,
                      color: MyColors.kColorWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),);
  }

  Widget dataVisible() {
    return Obx(() => isCollapse.value?Column(
      children: [
        rowColumn("Pin Code", prospectViewData.prospectDetails?.pinCode ?? ""),
        rowColumn("Office Address", prospectViewData.prospectDetails?.corporateOffice ?? ""),
        rowColumn(
            "Turn Over", prospectViewData.prospectDetails?.turnover ?? ""),
        rowColumn("Premium Achieved", prospectViewData.prospectDetails?.premiumAchived??"0"),
        rowColumn("Vertical","NA"),
        rowColumn("Parent Company",prospectViewData.prospectDetails?.parentCompany??""),
        rowColumn("Industry Type",prospectViewData.prospectDetails?.industryType??""),
        rowColumn("Write up/notes", prospectViewData.prospectDetails?.writeupNotes ?? ""),
        rowColumn("Name of Reference", prospectViewData.prospectDetails?.referee ?? ""),
        if(prospectViewData.contactperson.isNotEmpty)Column(children: contactData(),),
        const SizedBox(
          height: 10,
        ),
        if(prospectViewData.policies.isNotEmpty)Column(children: policieData(),),
        //uploadQuotation(),
      ],
    ):const SizedBox.shrink());
  }
  List<Widget> contactData(){
    List<Widget> widget = [];
    for(var i =0;i<=prospectViewData.contactperson.length-1;i++){
      widget.add(contactItem(prospectViewData.contactperson[i],i));
    }
    return widget;
  }



  Widget contactItem(Contactperson data,int index) {
    List<Widget> widget = [];
    widget.add(const SizedBox(
      height: 5,
    ));
    if(index>0){
      widget.add(const Divider(color: Palette.appColor,));
    }
    if(index==0) {
      widget.add(const SizedBox(
        height: 5,
      ));
      widget.add(
        Text("Contact Detail",
          style: TextStyles.headingTexStyle(
            color: Palette.kColorBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),),
      );
    }


    widget.add(rowColumn("Name", data.personName));
    widget.add(rowColumn("Designation", data.designation));
    widget.add(rowColumn("Address", data.personLocation));
    widget.add(rowColumn("Email ID", data.email));
    widget.add(rowColumn("Phone 1", data.phone));
    widget.add(rowColumn("Phone 2", data.phone2??"0"));
    widget.add(rowColumn("Birthday", data.birthday??"--/--/--"));
    widget.add(rowColumn("Anniversary", data.anniversary??"--/--/--"));
    widget.add(rowColumn("Key Declaration",data.decesionMaker));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget,
    );
  }
  List<Widget> policieData(){
    List<Widget> widget = [];
    for(var i =0;i<=prospectViewData.policies.length-1;i++){
      widget.add(policyPerticuller(prospectViewData.policies[i],i));
    }
    return widget;
  }
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
  Widget policyPerticuller(Policies data,int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if(index==0)Text("Policy Detail",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorBlack,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            )),
    if(index>0)const Divider(color: Palette.appColor,),
        rowColumn("Policy Type", data.policyType),
        rowColumn("Renewable Date", data.renewalDate),
        rowColumn("Sum insured", data.sumInsured),
        rowColumn("Premium", data.premiumPotential),
        rowColumn("Remark", data.remark),
        const SizedBox(height: 8,),
        InkWell(onTap: (){_launchUrl(data.policyFile);},child:

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidget / 3,
                child: Text(
                  "View Doc",
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorBlack,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(
                  width: screenWidget / 2,
                  child: Text(
                      "Tap to view",
                    style: TextStyles.headingTexStyle(
                      color: Palette.appColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget uploadQuotation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Upload Quotation",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorBlack,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            )),
        rowColumn("Policy Type", "Sonu Saini"),
        rowColumn("Renewable Date", "4 Feb 2022"),
        rowColumn("Sum insured", "345677"),
        rowColumn("Premium", "345677"),
        rowColumn("Remark", "345677"),
        rowColumn("View Doc", "N/A"),
      ],
    );
  }

  void actionPerform(context, String type) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
            side: BorderSide(color: Colors.white)),
        context: context,
        builder: (BuildContext c) {
          return SizedBox(
            height: screenHeight / 1.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  enquiaryOfferForm(screenWidget),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 1,
                    color: MyColors.themeColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      children: contactList(type),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> contactList(String type) {
    List<Widget> widgetList = [];
    prospectViewData.contactperson.forEach((element) {
      widgetList.add(_buildUserTile(element, type));
    });
    return widgetList;
  }

  ListTile _buildUserTile(Contactperson user, String type) {
    return ListTile(
      leading: NameIcon(firstName: user.personName),
      title: Row(
        children: [Text(user.personName)],
      ),
      onTap: () {
        if (type == "msg") _sendingSMS(user.phone);
        if (type == "email") _sendingMails(user.email);
        if (type == "call") launch("tel://${user.phone}");
        if (type == "whatApp") {
          //print('sonu');
          share(user.phone);
          //Uri.parse("whatsapp://send?phone=+919087898765&text=hello");
        }

        Get.back();
      },
    );
  }
  Future<void> share(String contact) async {
    {
      await launch(
          "https://wa.me/$contact?text=Hello");
    }
  }
  Widget enquiaryOfferForm(double screenWidget) {
    return Text("Contact List",
        textAlign: TextAlign.center,
        style: TextStyles.headingTexStyle(
            color: Palette.appBar,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'));
  }

  _sendingMails(String email) async {
    var url = Uri.parse("mailto:$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendingSMS(String phone) async {
    var url = Uri.parse("sms:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

