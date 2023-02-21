import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/prospect_list_controller.dart';
import '../../base/page.dart';

class ProspectsListPage extends AppPageWithAppBar {
  static const String routeName = "/ForgotPasswordPage";
  final controller = Get.put(ProspectListController());
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final  items = <String>[];
  ProspectsListPage({super.key});


    @override
    Widget get body {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          searchView,
          prospectList
      ])));
  }


  Widget get searchView {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {

        },
        controller: controller.searchViewController,
        decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }
  Widget get prospectList{
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${items[index]}'),
          );
        },
      ),
    );
  }
}