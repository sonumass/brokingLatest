import 'package:broking/model/meeting/Meeting_prospect.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/ui/commonWidget/text_style.dart';
import 'package:broking/ui/module/meetings/meeting_dashboard.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MeetingProspectCard extends BaseStateLessWidget {
   MeetingProspectCard( {super.key,required this.meetingProspect});
  final MeetingProspect meetingProspect;

  @override
  Widget build(BuildContext context) {
    return card;

  }
  Widget get card {
    return InkWell(
      onTap: () {

        MeetingDashboard.start(meetingProspect.prospectId ??"",
            meetingProspect.prospectName??"", meetingProspect.adddress??"");
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/png/ic_rerewable.svg',
              alignment: Alignment.center,
              width: screenWidget,
            ),
            Positioned(
                top: 20,
                right: 20,
                child: SvgPicture.asset("assets/png/ic_right_arrow.svg")),
            Positioned(
                top: 20,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelTextRow("Prospect Name:",meetingProspect.prospectName??""),
                    const SizedBox(
                      height: 10,
                    ),
                    labelTextRow("Prospect Address",meetingProspect.adddress??""),
                    const SizedBox(
                      height: 10,
                    ),
                    labelTextRow("Prospect city",meetingProspect.cityName??""),
                    const SizedBox(
                      height: 10,
                    ),
                    labelTextRow("Premium Potential",meetingProspect.premiumPotential??""),
                  ],
                )),
          ],
        ),
      ),
    );
  }
  Widget labelTextRow(String label, String textValue) {
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
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              textValue,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyles.headingTexStyle(
                color: Palette.prospectCardTextColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat',
              ),
            ),
          )
        ],
      ),
    );
  }
}