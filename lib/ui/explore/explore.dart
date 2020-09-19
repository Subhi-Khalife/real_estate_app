import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Api/get_filter_api.dart';
import 'package:real_estate_app/Provider/google_map_provider.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/bloc/bloc_get_all_country/country_bloc.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/ui/add_properity/add_property_spec_and_image.dart';
import 'file:///D:/projects/real_estate_app/lib/Provider/provier_property.dart';
import 'package:real_estate_app/ui/add_properity/required_param.dart';
import 'package:real_estate_app/ui/explore/filter_bottom_sheet.dart';
import 'file:///D:/projects/real_estate_app/lib/Provider/filter_provider.dart';
import 'package:real_estate_app/ui/explore/houses_category.dart';
import 'package:real_estate_app/ui/explore/spec_value_for_filter.dart';
import 'package:real_estate_app/ui/profile.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/show_message.dart';
import 'package:geolocator/geolocator.dart';
class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

Widget bottomSheet = null;

class _ExploreViewState extends State<ExploreView>with SingleTickerProviderStateMixin {

  TextEditingController textEditingController = TextEditingController();
  FilterProvider _filterProvider;
  GoogleMapProvider googleMapProvider;
  Widget titleWidget = Text(
    "Dalal",
    style: TextStyle(fontSize: 20, color: Colors.black54),
  );

  IconData iconAction = CupertinoIcons.search;

  ValueNotifier<bool> _searchNotifier = ValueNotifier(false);
  ValueNotifier<bool> _bottomSheetNotifier = ValueNotifier(false);
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
    _filterProvider = Provider.of<FilterProvider>(context, listen: false);
    _filterProvider.initValues();
    controller = TabController(length: 2, vsync: this, initialIndex: 0);
    googleMapProvider=Provider.of<GoogleMapProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.grey.shade100,
      body: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: tabs[tapIndex]),
            ),
            tapBar(),
            ValueListenableBuilder(
              valueListenable: _bottomSheetNotifier,
              builder: (context, _, __) {
                return AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    switchInCurve: Curves.easeInOutBack,
                    switchOutCurve: Curves.easeInOutBack,
                    reverseDuration: Duration(milliseconds: 1000),
                    child: bottomSheet);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: false,
      title: ValueListenableBuilder(
          valueListenable: _searchNotifier,
          builder: (context, _, __) {
            return AnimatedSwitcher(
                duration: Duration(milliseconds: 700),
                switchInCurve: Curves.easeIn,
                child: titleWidget);
          }),
      actions: <Widget>[
        ValueListenableBuilder(
          valueListenable: _searchNotifier,
          builder: (context, _, __) {
            return IconButton(
              icon: Icon(
                iconAction,
                color: Colors.black45,
                size: 20,
              ),
              onPressed: onSearchAction,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.black45,
            ),
            onPressed: () async {
              // print(  "The _filterProvider.firstTime ${_filterProvider.firstTime}");
              BlocProvider.of<AddProperetyDartBloc>(context)..add(LoadingData());
              return onFilterAction();
            },
          ),
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
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: TabBar(
                controller: controller,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "On Map",
                              style: TextStyle(
                                  color: tapIndex == 0
                                      ? activeIconNavBar
                                      : colorGrey,
                                  fontWeight: tapIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.w300),
                            ),
                            Icon(CupertinoIcons.location_solid,
                                size: 15,
                                color: tapIndex == 0
                                    ? activeIconNavBar
                                    : colorGrey),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Category",
                              style: TextStyle(
                                  color: tapIndex == 1
                                      ? activeIconNavBar
                                      : colorGrey,
                                  fontWeight: tapIndex == 1
                                      ? FontWeight.bold
                                      : FontWeight.w300),
                            ),
                            Icon(Icons.category,
                                size: 15,
                                color: tapIndex == 1
                                    ? activeIconNavBar
                                    : colorGrey),
                          ],
                        ),
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

  void onSearchAction() {
    _searchNotifier.value = !_searchNotifier.value;
    if (_searchNotifier.value) {
      titleWidget = Container(
        height: 40,
//        width: MediaQuery.of(context).size.width*0.6,
        child: TextFieldSearch(
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onSubmitted: (xx) {
            print("Errors");
            // requiredParam;
          },
          controller: _filterProvider.requiredParam.spaceSearchController,
          isShowIcon: false,
          hintText: "Search here.....",
        ),
      );
      iconAction = CupertinoIcons.clear_thick_circled;
    } else {
      titleWidget = Text(
        "Dalal",
        style: TextStyle(fontSize: 20, color: Colors.black54),
      );
      iconAction = CupertinoIcons.search;
    }
  }

  void onFilterAction() {
    _bottomSheetNotifier.value = !_bottomSheetNotifier.value;

    if (_bottomSheetNotifier.value)
      bottomSheet = FilterBottomSheet();
    else
      bottomSheet = null;
  }
}
