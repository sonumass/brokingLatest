import 'package:broking/ui/dialog/loader.dart';
import 'package:broking/utils/palette.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../controllers/mydashboard/my_dashboard_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';

class MyHomeDashboardPage extends AppPageWithAppBar {
  static const String routeName = "/MyHomeDashboardPage";
  final controller = Get.put(MyDashboardController());
  final appPreferences = Get.find<AppPreferences>();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final items = <String>[];

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(currentPageTitle: "My Dashboard", routeName);
  }

  MyHomeDashboardPage({super.key});

  @override // TODO: implement appBar
  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {
            // ProspectsCreatePage.start();
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
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: myText,
                  ),
                  SliverToBoxAdapter(
                    child: pastMeeting,
                  ),

                  SliverToBoxAdapter(
                    child: webView,
                  ),
                  /*SliverToBoxAdapter(
                    child: paiChart,
                  ),*/
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 8),
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
              padding: const EdgeInsets.only(left: 15, top: 0, bottom: 10),
              child: Text(
                "Dashboard",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SvgPicture.asset("assets/png/ic_avtar_icon.svg"),
        )
      ],
    );
  }

  Widget get pastMeeting {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/png/ic_ds_card.svg',
            alignment: Alignment.center,
            width: screenWidget,
          ),
          totalProspect(),
        ],
      ),
    );
  }
  Widget get webView{
   
    return Padding(padding: const EdgeInsets.only(left: 10,right: 10),child: SizedBox(width: screenWidget,height: screenHeight/1.2,child: InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.parse("https://3ditec.co.in/broking/mobilegraph/index/${appPreferences.userId}"),
      ),
      onWebViewCreated: (controller) {

      },
    ),),);
  }

  Widget totalProspect() {
    return Positioned(
        top: 30,
        left: 20,
        right: 30,
        child: Column(
          children: [
            rowData("Total Prospect",controller.myDashboardData?.totalProspects ??"0"),
            rowData("No Action taken",controller.myDashboardData?.noActionTaken ??"0"),
            rowData("Cold",controller.myDashboardData?.cold ??"0"),
            rowData("Moderate",controller.myDashboardData?.moderate ??"0"),
            rowData("Good",controller.myDashboardData?.good ??"0"),
            rowData("Partial Converted",controller.myDashboardData?.partiallyConverted ??"0"),
            rowData("Converted",controller.myDashboardData?.converted ??"0"),

          ],
        ));
  }
  Widget rowData(String label, String count){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.headingTexStyle(
            color: Palette.prospectCardTextColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        Card(
          color: Palette.textBgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: SizedBox(
            width: 70,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 3,
                  bottom: 3,
                ),
                child: Text(
                  count,
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get paiChart{
    Map<String, double> dataMap = {
      "Converted": double.parse(controller.myDashboardData?.converted??"0"),
      "Partial converted": double.parse(controller.myDashboardData?.partiallyConverted??"0"),
      "Good": double.parse(controller.myDashboardData?.good??"0"),
      "Moderate": double.parse(controller.myDashboardData?.moderate??"0"),
      "Cold": double.parse(controller.myDashboardData?.cold??"0"),
    };
    final colorList = <Color>[
      Colors.greenAccent,
      Colors.red,
      Colors.purple,
      Colors.amber,
      Colors.green,
      Colors.pink,
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/png/ic_ds_card.svg',
            alignment: Alignment.center,
            width: screenWidget,
          ),
          Positioned(left:20,top:100,child: PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(Get.context!).size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )),
        ],
      ),
    );
}
  Options getBroKingHeader() {
    Options options = Options();
    Map<String, dynamic> headers = Map();
    headers['API-KEY'] = r'BR!D$@!@#$';
    options.headers = headers;
    return options;
  }
}
