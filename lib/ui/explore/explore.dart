import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Api/add_property_api.dart';
import 'package:real_estate_app/Api/get_filter_api.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/bloc/bloc_get_all_country/country_bloc.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/ui/add_properity/add_property_spec_and_image.dart';
import 'package:real_estate_app/ui/add_properity/provier_property.dart';
import 'package:real_estate_app/ui/add_properity/required_param.dart';
import 'package:real_estate_app/ui/add_properity/spec_values.dart';
import 'package:real_estate_app/ui/explore/filter_provider.dart';
import 'package:real_estate_app/ui/explore/houses_category.dart';
import 'package:real_estate_app/ui/explore/spec_value_for_filter.dart';
import 'package:real_estate_app/ui/profile.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/show_message.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}
Widget bottomSheet = null;

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  FilterProvider _filterProvider;

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
              print( "The _filterProvider.firstTime ${_filterProvider.firstTime}");
              if (_filterProvider.firstTime == false) {
                print("Upload All Filter DAta");
                BlocProvider.of<AddProperetyDartBloc>(context)
                  ..add(LoadingData());
              }
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
          controller: TextEditingController(),
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

class FilterBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FilterBottomSheet();
  }
}

class _FilterBottomSheet extends State<FilterBottomSheet> {
  FilterProvider valueFromProvider;
  @override
  initState() {
    super.initState();
    valueFromProvider = Provider.of<FilterProvider>(context, listen: false);
  }

  RequiredParam requiredParam = RequiredParam();
  // Prov

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {

        // if (valueFromProvider.filtersValues.length != 0) {
          // print(
          //     "the length before clear ${valueFromProvider.filtersValues.length}");
          // Data items = valueFromProvider.filtersValues.removeLast();
          // print(
          //     "the length after clear ${valueFromProvider.filtersValues.length}");
          // GetAllTypeApi getAllTypeApi =
          //     GetAllTypeApi(status: "OK", data: items.newFilter);
          // BlocProvider.of<AddProperetyDartBloc>(context)
          //   ..add(ShowSpecEvent(-1, getAllTypeApi));
          // BlocProvider.of<ExploreDartBloc>(context)
          //   ..add(ChangeValuesEvent(items: items));
        // }
      },
      child: DraggableScrollableSheet(
          maxChildSize: 0.85,
          initialChildSize: 0.4,
          minChildSize: 0.25,
          builder: (context, scrollController) {
            return Container(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return (index == 0)
                      ? Center(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Advance Filter",
                            style: TextStyle(color: colorApp, fontSize: 18),
                          ),
                        ))
                      : (index == 1)
                          ? showCollapse(0, "نوع العقار ")
                          : secondPage(propertyProvider);
                },
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            );
          }),
    );
  }

  bool checkFields(GetAllTypeApi getAllTypeApi) {
    int typeSpecsLength =
    getAllTypeApi.data[requiredParam.houseIndex[0]].typeSpecs.length;
    print("the length is :: $typeSpecsLength");
    requiredParam.specValues.clear();
    print("the house index is :: ${requiredParam.houseIndex[0]}");

    /// Add Spec Values To Array
    print("Add Spec Values To Array");
    print("Add Spec Values To Array $getAllTypeApi");
    for (int i = 0; i < typeSpecsLength; i++) {
      print("okes");
      // bool hasOptions = getAllTypeApi.data[requiredParam.houseIndex[0]].typeSpecs[i].hasOption;
      // if (hasOptions == false) {
      //   SpecValues specValues = SpecValues(
      //       id: getAllTypeApi.data[requiredParam.houseIndex[0]].typeSpecs[i].id,
      //       option: null,
      //       value: requiredParam.controller[i].text);
      //   requiredParam.specValues.add(specValues);
      // } else {
      SpecValuesForFilter specValues = SpecValuesForFilter(
        id: getAllTypeApi.data[requiredParam.houseIndex[0]].typeSpecs[i].id,
        option: requiredParam.specID[i + 1],
      );
      requiredParam.specValuesForFilter.add(specValues);
      // }
    }
    print(
        'the length requiredParam.specValuesForFilter :: ${requiredParam.specValuesForFilter.length}');
    // for (int i = 0; i < requiredParam.specValuesForFilter.length; i++) {
    //   print("the id is :: ${getAllTypeApi.data[requiredParam.houseIndex[0]].typeSpecs[i].id}");
    //   print("the option is :: ${requiredParam.specValuesForFilter[i].option}");
    // }
    print("Done");
    return true;
  }

  Widget showOtheInfo(GetAllTypeApi items, int selectedValue) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: CollapseView(
            title: "نوع العقار",
            getAllTypeApi: items,
            index: index + 1,
            specID: requiredParam.specID,
            first: requiredParam.first,
            typeId: requiredParam.typeId,
            values: requiredParam.collapse,
            controller: requiredParam.controller,
            textEditingController: requiredParam.controller[index],
            houseTypeIndex: requiredParam.houseIndex,
          ),
        );
      },
      itemCount: items.data[selectedValue].typeSpecs.length,
    );
  }

  showDataCountries(PropertyProvider provider) {
    return BlocBuilder<CountryBloc, CountryState>(
      cubit: BlocProvider.of<CountryBloc>(context),
      builder: (context, state) {
        if (state is Wait)
          return Center(
              child: CupertinoActivityIndicator(
            radius: 10,
            animating: true,
          ));
        else if (state is FetchAllCountry) {

          return ListView.builder(
              itemCount: state.countryModel.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.countryModel.data[index].cities.length,
                    itemBuilder: (context, position) {
                      return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Divider(
                              indent: 10,
                              endIndent: 20,
                            );
                          },
                          itemCount: state.countryModel.data[index]
                              .cities[position].areas.length,
                          itemBuilder: (context, indexArea) {
                            return InkWell(
                              onTap: () {
                                requiredParam.isVal.value = false;
                                requiredParam.title.value = state
                                    .countryModel
                                    .data[index]
                                    .cities[position]
                                    .areas[indexArea]
                                    .name;
                                requiredParam.areaId = state
                                    .countryModel
                                    .data[index]
                                    .cities[position]
                                    .areas[indexArea]
                                    .id;
                                requiredParam.address =
                                    requiredParam.title.value;
                                requiredParam.colorTextCountry.value = colorApp;
                                provider.setAreaIdValue(requiredParam.areaId);
                                provider.setAddressValue(requiredParam.address);
                                print("areaId ${provider.areaId}");
                                print(
                                    "area id ${provider.areaId} address ${provider.address}");
                              },
                              child: Container(
                                child: Text(state.countryModel.data[index]
                                    .cities[position].areas[indexArea].name),
                              ),
                            );
                          });
                    });
              });
        } else if (state is FailedGetAllCountries)
          return Column(
            children: <Widget>[
              Text("No internet connection"),
              IconButton(
                icon: Icon(Icons.restore),
                onPressed: () {
//                  BlocProvider.of<AddProperetyDartBloc>(context)..add(GetAllCountry());
                },
              ),
            ],
          );
        return Container(
          width: 100,
          height: 100,
          color: Colors.green,
        );
      },
    );
  }

  Widget secondPage(PropertyProvider propertyProvider) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Card(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: ShowCollapseCountry(
            title: requiredParam.title,
            isShowItems: requiredParam.isVal,
            showBorder: true,
            color: requiredParam.colorTextCountry.value,
            padding: EdgeInsets.all(10.0),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: colorApp,
            ),
            body: showDataCountries(propertyProvider),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: ShowCollapseCountry(
            title: requiredParam.useTypeTitle,
            isShowItems: requiredParam.useTypeVal,
            showBorder: true,
            color: requiredParam.colorTextUseType.value,
            padding: EdgeInsets.all(10.0),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: colorApp,
            ),
            body: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      requiredParam.useTypeTitle.value =
                          requiredParam.useTypes[index];
                      requiredParam.useTypeVal.value = false;
                      requiredParam.colorTextUseType.value = colorApp;
                      if (requiredParam.useTypes[index] == "إيجار")
                        propertyProvider.setUseTypeValue("rent");
                      else if (requiredParam.useTypes[index] == "رهن")
                        propertyProvider.setUseTypeValue("mortgage");
                      else
                        propertyProvider.setUseTypeValue("sell");

                      print("ustType value ${propertyProvider.useType}");
                    },
                    child: Container(
                      child: Text(requiredParam.useTypes[index]),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      indent: 10.0,
                      endIndent: 20.0,
                    ),
                itemCount: requiredParam.useTypes.length),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  child: TextFieldApp(
                    controller: requiredParam.minPrice,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اقل سعر ممكن",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context)
                          .requestFocus(requiredParam.priceNode);
                    },
                    onChange: (val) {
                      print(val);
                      propertyProvider.setSpaceValue(double.parse(val));
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatter: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]"))
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  child: TextFieldApp(
                    controller: requiredParam.maxPrice,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اكبر سعر ممكن",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context)
                          .requestFocus(requiredParam.priceNode);
                    },
                    onChange: (val) {
                      print(val);
                      propertyProvider.setSpaceValue(double.parse(val));
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatter: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]"))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(color: Colors.grey),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  child: TextFieldApp(
                    controller: requiredParam.minSpace,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اقل مساحة ممكنة",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context)
                          .requestFocus(requiredParam.priceNode);
                    },
                    onChange: (val) {
                      print(val);
                      propertyProvider.setSpaceValue(double.parse(val));
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatter: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]"))
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  child: TextFieldApp(
                    controller: requiredParam.maxSpace,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اكبر مساحة ممكن",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context)
                          .requestFocus(requiredParam.priceNode);
                    },
                    onChange: (val) {
                      print(val);
                      propertyProvider.setSpaceValue(double.parse(val));
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatter: [
                      WhitelistingTextInputFormatter(RegExp("[0-9]"))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(color: Colors.grey),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: colorApp,
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Center(
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          onPressed: () async {
            if (BlocProvider.of<AddProperetyDartBloc>(context).state.props[1] !=
                -1) {
              checkFields(BlocProvider.of<AddProperetyDartBloc>(context)
                  .state
                  .props[0]);
            }
            requiredParam.useTypeValue = propertyProvider.useType;
            FilterModel values =
                await GetFilterApi.getFilter(requiredParam: requiredParam);
            if (values.status == "OK") {
              print("Finally Length is ${values.data.properties.data.length}");
              valueFromProvider.setNewFilter(values.data);
              print("11");
              BlocProvider.of<ExploreDartBloc>(context)..add(ChangeValuesEvent(items: values.data));
              print("22");
              GetAllTypeApi getAllTypeApi = GetAllTypeApi(status: "OK", data: values.data.newFilter);
              print("33");
              print("44");
              print(values.data.newFilter.length);
              // BlocProvider.of<AddProperetyDartBloc>(context)..add(ShowSpecEvent(-1, getAllTypeApi));
              requiredParam = new RequiredParam();
            }

            // BlocProvider.of<AddProperetyDartBloc>(context)..add(ShowSpecEvent( -1,
            // BlocProvider.of<AddProperetyDartBloc>(context).state.props[0]));
            //
            // // ShowSpecEvent
          },
        )
      ],
    );
  }

  Widget errorScreen() {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AddProperetyDartBloc>(context)..add(LoadingData());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
            onTap: () {
              BlocProvider.of<AddProperetyDartBloc>(context)
                ..add(LoadingData());
            },
            child: Center(child: Text("الرجاء اعد المحاولة من جديد "))),
      ),
    );
  }

  Widget showCollapse(int, String title) {
    return BlocBuilder<AddProperetyDartBloc, AddProperetyDartState>(
      cubit: BlocProvider.of<AddProperetyDartBloc>(context),
      builder: (context, AddProperetyDartState state) {
        print("the state is Wait :: ${state is Wait}");
        print("the state is Error :: ${state is Error}");
        print("the state is Loading :: ${state is LoadingData}");

        if (state is Wait) {
          print("2222222222222222");

          return isLoading();
        } else if (state is InsertAllPropertyType) {
          valueFromProvider.setFirstTime(true);

          print("11111111111");
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 8),
                child: CollapseView(
                  title: "نوع العقار",
                  getAllTypeApi: state.type,
                  index: 0,
                  values: requiredParam.collapse,
                  specID: requiredParam.specID,
                  first: requiredParam.first,
                  controller: requiredParam.controller,
                  textEditingController: requiredParam.proprtyController,
                  houseTypeIndex: requiredParam.houseIndex,
                  typeId: requiredParam.typeId,
                ),
              ),
              (state.index != -1)
                  ? showOtheInfo(state.type, state.index)
                  : Container(),
            ],
          );
        } else if (state is Error) {
          print("3333333333333");

          return errorScreen();
        } else {
          print("444444444444");

          return Container();
        }
      },
    );
  }

  Widget isLoading() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
