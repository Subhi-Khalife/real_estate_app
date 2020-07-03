import 'package:flutter/material.dart';
import 'package:projects/ui/explore/houses_category.dart';
import 'package:projects/ui/profile.dart';
import 'package:projects/widget/color_app.dart';
import 'package:projects/widget/global_widget.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();

  final tabs = [
    ProfileView(),
    HousesCategory(),
  ];
  TabController controller;
  int tapIndex;
  @override
  void initState() {
    super.initState();
    tapIndex = 0;
    controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 60, bottom: 10),
                child: tabs[tapIndex],
              ),
              tapBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      actions: <Widget>[
        TextFieldSearch(controller: textEditingController),
        Padding(
          padding: const EdgeInsets.only(left: 4,right: 4),
          child: IconButton(
              icon: Icon(
                Icons.brush,
                color: Colors.black,
              ),
              onPressed: () {}),
        ),
      ],
    );
  }

  Widget tapBar() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 0, right: 6, left: 6),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: TabBar(
                controller: controller,
                onTap: (int a) {
                  setState(() {
                    tapIndex = a;
                    print('tabIndex $tapIndex');
                  });
                },
                isScrollable: true,
                labelColor: tabBarColor,
                indicatorColor: tabBarColor,
                labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                tabs: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Tab(
                        text: "On Map",
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Tab(
                        text: "Categiry",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
