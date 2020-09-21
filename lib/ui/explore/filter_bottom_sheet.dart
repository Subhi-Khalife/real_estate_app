import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Api/get_filter_api.dart';
import 'package:real_estate_app/Provider/google_map_provider.dart';
import 'package:real_estate_app/Provider/house_category_provider.dart';
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
import 'package:real_estate_app/ui/house_detail.dart';
import 'package:real_estate_app/ui/profile.dart';
import 'package:real_estate_app/widget/card_info.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/loading_dialog.dart';
import 'package:real_estate_app/widget/show_message.dart';
import 'package:geolocator/geolocator.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FilterBottomSheet();
  }
}

class _FilterBottomSheet extends State<FilterBottomSheet> {
  FilterProvider valueFromProvider;
  GoogleMapProvider googleMapProvider;
  HousesCategoryProvider housesCategoryProvider;
  @override
  initState() {
    super.initState();
    valueFromProvider = Provider.of<FilterProvider>(context, listen: false);
    googleMapProvider = Provider.of<GoogleMapProvider>(context, listen: false);
    housesCategoryProvider =   Provider.of<HousesCategoryProvider>(context, listen: false);

  }

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
    int typeSpecsLength = getAllTypeApi
        .data[valueFromProvider.requiredParam.houseIndex[0]].typeSpecs.length;
    print("the length is :: $typeSpecsLength");
    valueFromProvider.requiredParam.specValues.clear();
    print(
        "the house index is :: ${valueFromProvider.requiredParam.houseIndex[0]}");

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
        id: getAllTypeApi.data[valueFromProvider.requiredParam.houseIndex[0]]
            .typeSpecs[i].id,
        option: valueFromProvider.requiredParam.specID[i + 1],
      );
      valueFromProvider.requiredParam.specValuesForFilter.add(specValues);
      // }
    }
    print(
        'the length requiredParam.specValuesForFilter :: ${valueFromProvider.requiredParam.specValuesForFilter.length}');
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
            specID: valueFromProvider.requiredParam.specID,
            first: valueFromProvider.requiredParam.first,
            typeId: valueFromProvider.requiredParam.typeId,
            values: valueFromProvider.requiredParam.collapse,
            controller: valueFromProvider.requiredParam.controller,
            textEditingController:
                valueFromProvider.requiredParam.controller[index],
            houseTypeIndex: valueFromProvider.requiredParam.houseIndex,
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
                                valueFromProvider.requiredParam.isVal.value =
                                    false;
                                valueFromProvider.requiredParam.title.value =
                                    state.countryModel.data[index]
                                        .cities[position].areas[indexArea].name;
                                valueFromProvider.requiredParam.areaId = state
                                    .countryModel
                                    .data[index]
                                    .cities[position]
                                    .areas[indexArea]
                                    .id;
                                valueFromProvider.requiredParam.address =
                                    valueFromProvider.requiredParam.title.value;
                                valueFromProvider.requiredParam.colorTextCountry
                                    .value = colorApp;
                                provider.setAreaIdValue(
                                    valueFromProvider.requiredParam.areaId);
                                provider.setAddressValue(
                                    valueFromProvider.requiredParam.address);
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
            title: valueFromProvider.requiredParam.title,
            isShowItems: valueFromProvider.requiredParam.isVal,
            showBorder: true,
            color: valueFromProvider.requiredParam.colorTextCountry.value,
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
            title: valueFromProvider.requiredParam.useTypeTitle,
            isShowItems: valueFromProvider.requiredParam.useTypeVal,
            showBorder: true,
            color: valueFromProvider.requiredParam.colorTextUseType.value,
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
                      valueFromProvider.requiredParam.useTypeTitle.value =
                          valueFromProvider.requiredParam.useTypes[index];
                      valueFromProvider.requiredParam.useTypeVal.value = false;
                      valueFromProvider.requiredParam.colorTextUseType.value =
                          colorApp;
                      if (valueFromProvider.requiredParam.useTypes[index] ==
                          "إيجار")
                        propertyProvider.setUseTypeValue("rent");
                      else if (valueFromProvider
                              .requiredParam.useTypes[index] ==
                          "رهن")
                        propertyProvider.setUseTypeValue("mortgage");
                      else
                        propertyProvider.setUseTypeValue("sell");

                      print("ustType value ${propertyProvider.useType}");
                    },
                    child: Container(
                      child:
                          Text(valueFromProvider.requiredParam.useTypes[index]),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      indent: 10.0,
                      endIndent: 20.0,
                    ),
                itemCount: valueFromProvider.requiredParam.useTypes.length),
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
                    controller: valueFromProvider.requiredParam.minPrice,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اقل سعر ممكن",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(
                          valueFromProvider.requiredParam.priceNode);
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
                    controller: valueFromProvider.requiredParam.maxPrice,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اكبر سعر ممكن",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(
                          valueFromProvider.requiredParam.priceNode);
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
                    controller: valueFromProvider.requiredParam.minSpace,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اقل مساحة ممكنة",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(
                          valueFromProvider.requiredParam.priceNode);
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
                    controller: valueFromProvider.requiredParam.maxSpace,
                    isTextFieldPassword: false,
                    hintText: "",
                    labelText: "اكبر مساحة ممكن",
                    isLengthSmall: true,
                    onSubmitted: (val) {
                      FocusScope.of(context).requestFocus(
                          valueFromProvider.requiredParam.priceNode);
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
          height: 14,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: TextFieldApp(
            controller: valueFromProvider.requiredParam.spaceSearchController,
            isTextFieldPassword: false,
            hintText: "",
            labelText: "البعد عن المكان الحالي",
            isLengthSmall: true,
            onSubmitted: (val) {
              FocusScope.of(context)
                  .requestFocus(valueFromProvider.requiredParam.priceNode);
            },
            onChange: (val) {
              print(val);
              propertyProvider.setSpaceValue(double.parse(val));
            },
            keyboardType: TextInputType.phone,
            inputFormatter: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
          ),
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
            Position position;
            print("ok");

            if (valueFromProvider.requiredParam.spaceSearchController.text.trim() .isNotEmpty) {
              final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
              LoadingDialog loadingDialog = LoadingDialog(context);
              loadingDialog.show(context);
              try {
                position = await geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.best);
              } catch (e) {}
              loadingDialog.dismiss(context);
              print(position);
              valueFromProvider.requiredParam.latitude = position.latitude;
              valueFromProvider.requiredParam.longitude = position.longitude;
            }

            if (BlocProvider.of<AddProperetyDartBloc>(context).state.props[1] !=-1) {
              checkFields(BlocProvider.of<AddProperetyDartBloc>(context) .state.props[0]);
            }
            valueFromProvider.requiredParam.useTypeValue = propertyProvider.useType;
            FilterModel values = await GetFilterApi.getFilter(
                requiredParam: valueFromProvider.requiredParam,
                context: context);
            if (values.status == "OK") {
              housesCategoryProvider.addValues(values.data);
              print("Finally Length is ${values.data.properties.data.length}");
              valueFromProvider.setNewFilter(values.data);
              BlocProvider.of<ExploreDartBloc>(context)..add(ChangeValuesEvent(items: values.data));
              GetAllTypeApi getAllTypeApi =GetAllTypeApi(status: "OK", data: values.data.newFilter);
              print(values.data.newFilter.length);
              googleMapProvider.marker.clear();
              drawCircle(position);
              drawPoint(values);
              valueFromProvider.requiredParam = new RequiredParam();
            }
          },
        )
      ],
    );
  }

  void drawPoint(FilterModel values) {
    for (int i = 0; i < values.data.properties.data.length; i++) {
      if (values.data.properties.data[i].longitude != null &&
          values.data.properties.data[i].latitude != null) {
        final marker = Marker(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HouesDetail(
                    properties: values.data.properties.data[i],
                  )));
            },
            markerId: MarkerId(values.data.properties.data[i].id.toString()),
            position: LatLng(
              values.data.properties.data[i].latitude,
              (values.data.properties.data[i].longitude),
            ));
        googleMapProvider.addToMarker(marker);
      }
    }
  }

  void drawCircle(Position position) {
    print("inside Drawe Circle");
    if (valueFromProvider.requiredParam.spaceSearchController.text
        .trim()
        .isNotEmpty) {
      googleMapProvider.addToCircle(Circle(
        visible: true,
        circleId: CircleId("id"),
        fillColor: Colors.green.withOpacity(0.3),
        zIndex: 3,
        strokeColor: Colors.green.withOpacity(0.3),
        consumeTapEvents: true,
        onTap: () {
          print("test");
        },
        strokeWidth: 0,
        center: LatLng(position.latitude, position.longitude),
        radius: double.parse(
            valueFromProvider.requiredParam.spaceSearchController.text)*1000,
      ));
    }
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
                  values: valueFromProvider.requiredParam.collapse,
                  specID: valueFromProvider.requiredParam.specID,
                  first: valueFromProvider.requiredParam.first,
                  controller: valueFromProvider.requiredParam.controller,
                  textEditingController:
                      valueFromProvider.requiredParam.proprtyController,
                  houseTypeIndex: valueFromProvider.requiredParam.houseIndex,
                  typeId: valueFromProvider.requiredParam.typeId,
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
