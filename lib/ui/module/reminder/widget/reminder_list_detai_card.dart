import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../model/reminder/detailList/ReminderDataList.dart';
import '../../../commonWidget/text_style.dart';

class ReminderDetailListCard extends BaseStateLessWidget {
  ReminderDetailListCard({super.key, required this.data});

  final List<DataList> data;

  @override
  Widget build(BuildContext context) {
    return card;
  }

  Widget get card {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/png/ic_reminder_list_icon.svg',
            alignment: Alignment.center,
            width: screenWidget,
          ),
          Positioned(
              top: 8,
              left: 40,
              right: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: setChild,
              )),
        ],
      ),
    );
  }

  List<Widget> get setChild {
    List<Widget> list = [];
    for (var element in data) {
      list.add(labelTextRow(element.label, element.value));
    }

    return list;
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
