import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/explore/houses_category.dart';
import 'package:real_estate_app/ui/profile.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();

  Widget titleWidget = Text("Dalal",style: TextStyle(
    fontSize: 20,color: Colors.black54
  ),);

  IconData iconAction = CupertinoIcons.search;

  Widget bottomSheet = null;

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
    controller = TabController(length: 2, vsync: this, initialIndex: 0);
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                  child: tabs[tapIndex]),
            ),
            tapBar(),
            ValueListenableBuilder(
              valueListenable: _bottomSheetNotifier,
              builder: (context,_,__){
                return AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    switchInCurve: Curves.easeInOutBack,
                    switchOutCurve: Curves.easeInOutBack,reverseDuration: Duration(milliseconds: 1000),
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
        builder: (context,_,__) {
          return AnimatedSwitcher(
              duration: Duration(
                  milliseconds: 700
              ),
              switchInCurve: Curves.easeIn,
              child:titleWidget);
        }
      ),
      actions: <Widget>[
        ValueListenableBuilder(
          valueListenable: _searchNotifier,
          builder: (context, _,__) {
            return IconButton(
              icon: Icon(iconAction,color: Colors.black45,size: 20,),
              onPressed: onSearchAction,
            );
          }
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4,right: 4),
          child: IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.black45,
              ),
              onPressed: onFilterAction),
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
                           Text("On Map",style: TextStyle(
                               color: tapIndex == 0 ?activeIconNavBar: colorGrey,fontWeight: tapIndex==0? FontWeight.bold :FontWeight.w300
                            ),
                           ),
                           Icon(CupertinoIcons.location_solid,size: 15,color: tapIndex == 0 ?activeIconNavBar: colorGrey),
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
                          mainAxisSize:MainAxisSize.min,
                          children: <Widget>[
                            Text("Category",style: TextStyle(
                                color: tapIndex == 1 ?activeIconNavBar: colorGrey,fontWeight: tapIndex==1 ? FontWeight.bold :FontWeight.w300
                            ),),
                            Icon(Icons.category,size: 15,color: tapIndex == 1 ?activeIconNavBar: colorGrey),
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
    if(_searchNotifier.value)
      {
        titleWidget = Container(
          height: 40,
//        width: MediaQuery.of(context).size.width*0.6,
          child: TextFieldSearch(
            controller: TextEditingController(),
            isShowIcon: false,
            hintText: "Search here.....",
          ),
        );
        iconAction = CupertinoIcons.clear_thick_circled;
      }
    else
     {
       titleWidget = Text("Dalal",style: TextStyle(
           fontSize: 20,color: Colors.black54
       ),);
       iconAction = CupertinoIcons.search;
     }
  }

  void onFilterAction() {
    _bottomSheetNotifier.value = !_bottomSheetNotifier.value;

    if(_bottomSheetNotifier.value)
      bottomSheet = FilterBottomSheet();
    else
      bottomSheet =null;
  }
}
class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  DraggableScrollableSheet(
        maxChildSize: 0.85,
        initialChildSize: 0.4,
        minChildSize: 0.25,
        builder: (context, scrollController) {
          return Container(
            child: ListView.builder(
              controller: scrollController,
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text('Item index'));
              },
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,

              /// To set radius of top left and top right
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          );
        },
      );

  }
}
