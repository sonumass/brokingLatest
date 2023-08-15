import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../commonWidget/text_style.dart';
import '../reminder_list_detail_list.dart';
class ReminderListCard extends BaseStateLessWidget {
  final String cardName;

  final String count;

  const ReminderListCard(
      {super.key, required this.cardName, required this.count});

  @override
  Widget build(BuildContext context) {
    return card;
  }

  Widget get card {
    return InkWell(
      onTap: () {
        ReminderDetailListPage.start(cardName, "",cardName);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/png/ic_reminder_card.svg',
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
                    Text(
                      cardName,
                      style: TextStyles.headingTexStyle(
                        color: Palette.prospectCardTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      count,
                      style: TextStyles.headingTexStyle(
                        color: Palette.prospectCardTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
