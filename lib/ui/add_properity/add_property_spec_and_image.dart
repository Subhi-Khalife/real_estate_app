import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Api/add_property_api.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/ui/add_properity/provier_property.dart';
import 'package:real_estate_app/ui/add_properity/required_param.dart';
import 'package:real_estate_app/ui/add_properity/spec_values.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/list_image.dart';
import 'package:real_estate_app/widget/show_message.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_collapse/flutter_collapse.dart';
import 'package:real_estate_app/bloc/bloc_get_all_country/country_bloc.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AddPropertySpecAndImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPropertySpecAndImage();
  }
}

class _AddPropertySpecAndImage extends State<AddPropertySpecAndImage> {
  RequiredParam requiredParam;
  PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  void initState() {
    super.initState();
    requiredParam = RequiredParam();
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = Provider.of<PropertyProvider>(context);
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<AddProperetyDartBloc>(context)..add(LoadingData());
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  showCollapse(0, "نوع العقار "),
                ],
              ),
              secondPage(propertyProvider),
              thirdPage(propertyProvider)
            ],
          ),
        ),
      ),
    );
  }

  Widget secondPage(PropertyProvider propertyProvider){
    return ListView(
      children: <Widget>[
        Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          child: ShowCollapseCountry(
            title: requiredParam.title,
            isShowItems: requiredParam.isVal,
            showBorder: true,
            color: requiredParam.colorTextCountry.value,
            padding: EdgeInsets.all(10.0),
            icon: Icon(Icons.keyboard_arrow_down,color: colorApp,),
            body: showDataCountries(propertyProvider),
          ),
        ),
        SizedBox(height: 10,),
        Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          ),
          child: ShowCollapseCountry(
            title: requiredParam.useTypeTitle,
            isShowItems: requiredParam.useTypeVal,
            showBorder: true,
            color: requiredParam.colorTextUseType.value,
            padding: EdgeInsets.all(10.0),
            icon: Icon(Icons.keyboard_arrow_down,color: colorApp,),
            body: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      requiredParam.useTypeTitle.value = requiredParam.useTypes[index];
                      requiredParam.useTypeVal.value = false;
                      requiredParam.colorTextUseType.value =colorApp;
                      if(requiredParam.useTypes[index] == "إيجار")
                        propertyProvider.setUseTypeValue("rent");
                      else if(requiredParam.useTypes[index] == "رهن")
                        propertyProvider.setUseTypeValue("mortgage");
                      else
                        propertyProvider.setUseTypeValue("sell");

                      print("ustType value ${propertyProvider.useType}");
                    },
                    child: Container(
                      child: Text(requiredParam.useTypes[index]),
                    ),
                  );
                }, separatorBuilder: (context,index) =>Divider(
              indent: 10.0,endIndent: 20.0,
            ), itemCount: requiredParam.useTypes.length),
          ),
        ),
        SizedBox(height: 10,),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFieldApp(
            controller:requiredParam.spaceController,
            isTextFieldPassword: false,
            hintText: "المساحة(بالمتر) *",
            isLengthSmall: true,
            onSubmitted: (val){
              FocusScope.of(context).requestFocus(requiredParam.priceNode);
            },
            onChange: (val){
              print(val);
              propertyProvider.setSpaceValue(double.parse(val));
            },
            keyboardType: TextInputType.phone,
            inputFormatter: [
              WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
          ),
        ),
        SizedBox(height: 10,),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFieldApp(
            controller:requiredParam.priceController,
            isTextFieldPassword: false,
            hintText: "السعر(ليرة سوري) *",
            focusNode: requiredParam.priceNode,
            onChange: (val){
              propertyProvider.setPriceValue(int.parse(val));
            },
            onSubmitted: (val){
              FocusScope.of(context).requestFocus(requiredParam.postalCodeNode);
            },
            keyboardType: TextInputType.phone,
            inputFormatter: [
              WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
          ),
        ),
        SizedBox(height: 10,),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextFieldApp(
            controller:requiredParam.postalCodeController,
            isTextFieldPassword: false,
            focusNode: requiredParam.postalCodeNode,
            onChange: (val){
              propertyProvider.setPostalCodeValue(double.parse(val));
            },
            hintText: "الكود البريدى (اختياري)",
            isLengthSmall: true,
            keyboardType: TextInputType.phone,
            inputFormatter: [
              WhitelistingTextInputFormatter(RegExp("[0-9]"))
            ],
          ),
        ),
        SizedBox(height: 50,),
        Container(
            width: MediaQuery.of(context).size.width,
            child: ButtonApp(onPressed: (){
                checkData(propertyProvider);
            }, textButton: "Following",colorButton: colorApp)),
        Container(
            width: MediaQuery.of(context).size.width,
            child: ButtonApp(onPressed: (){
              _pageController.previousPage(duration: Duration(milliseconds: 800), curve: Curves.easeIn);
            }, textButton: "Previous",colorButton: colorApp)),
      ],
    );
  }

  Widget thirdPage(PropertyProvider propertyProvider)
  {
    return Padding(
      padding:  EdgeInsets.only(left: 0,right: 0,bottom: 0),
      child: Column(
        children: <Widget>[
          showMap(propertyProvider),
          Spacer(),
          Container(
              width: MediaQuery.of(context).size.width,
              child: ButtonApp(onPressed: (){
                print("mypPositionProperty ${propertyProvider.latitude}  ${propertyProvider.longitude}");
                _pageController.previousPage(duration: Duration(milliseconds: 800), curve: Curves.easeIn);
              }, textButton: "Previous",colorButton: colorApp)),
          SizedBox(height: 5,),
          Container(
              width: MediaQuery.of(context).size.width,
              child: ButtonApp(onPressed: (){
                addPropertyAction(propertyProvider);
                print("providerval  $propertyProvider");
              }, textButton: "Add Property",colorButton: colorApp)),
        ],
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
          print("11111111111");
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  checkFields(state.type);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                child: addImage(state.type),
              ),
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
              MaterialButton(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  if (checkFields(state.type)) {
                    showMessage("جميع المعلومات صحيحة");
                    _pageController.nextPage(duration: Duration(milliseconds: 700), curve: Curves.easeIn);
                  } else {
                    showMessage("حدث خطا في الإدخال");
                  }
                },
                color: colorApp,
                child: Text(
                  "Following",
                  style: TextStyle(color: Colors.white),
                ),
              )
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

  Widget isLoading() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget showOtheInfo(GetAllTypeApi items, int selectedValue) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return (items.data[selectedValue].typeSpecs[index].hasOption == false)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFieldApp(
                    controller: requiredParam.controller[index],
                    labelText: items.data[selectedValue].typeSpecs[index].name,
                    isTextFieldPassword: false,
                  ),
                ),
              )
            : Padding(
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

  bool checkFields(GetAllTypeApi getAllTypeApi) {
    int typeSpecsLength =
        getAllTypeApi.data[requiredParam.houseIndex[0]].typeSpecs.length;

    requiredParam.specValues.clear();
    print("the house index is :: ${requiredParam.houseIndex[0]}");
    if (requiredParam.typeId[0] == -1) {
      showMessage("قم باختيار نوع العقار المطلوب");
    } else {
      for (int i = 0; i < typeSpecsLength; i++) {
        bool hasOptions = getAllTypeApi
            .data[requiredParam.houseIndex[0]].typeSpecs[i].hasOption;
        bool hasMutipleOptions = getAllTypeApi
            .data[requiredParam.houseIndex[0]].typeSpecs[i].hasMultipleOption;
        if (hasOptions == false &&
            requiredParam.controller[i].text.trim() == "") {
          showMessage("الرجاء قم بادخال جميع الحقول المطلوبة ");
          return false;
        } else if (hasOptions == true &&
            hasMutipleOptions == false &&
            requiredParam.specID[i + 1].length == 0) {
          showMessage("تاكد من ادخال جميع الحقول المطلوبة");
          return false;
        } else if (hasOptions == true &&
            hasMutipleOptions == true &&
            requiredParam.specID[i + 1].length == 0) {
          showMessage("تاكد من ادخال جميع الحقول المطلوبة");
          return false;
        }
      }
      if (requiredParam.propertyImages.length == 0) {
        showMessage("يجب إدخال الصورة الرئيسية للعقار");
        return false;
      } else if (requiredParam.propertyImages.length == 1) {
        showMessage("يجب إدخال الصورة فرعية واحدة على الاقل");
        return false;
      }

      /// Add Spec Values To Array
      print("Add Spec Values To Array");
      for (int i = 0; i < typeSpecsLength; i++) {
        bool hasOptions = getAllTypeApi
            .data[requiredParam.houseIndex[0]].typeSpecs[i].hasOption;
        if (hasOptions == false) {
          SpecValues specValues = SpecValues(
              id: requiredParam.typeId[0],
              option: null,
              value: requiredParam.controller[i].text);
          requiredParam.specValues.add(specValues);
        } else {
          SpecValues specValues = SpecValues(
              id: requiredParam.typeId[0],
              option: requiredParam.specID[i + 1],
              value: null);
          requiredParam.specValues.add(specValues);
        }
      }
      for (int i = 0; i < requiredParam.specValues.length; i++) {
        print("the id is :: ${requiredParam.specValues[i].id}");
        print("the option is :: ${requiredParam.specValues[i].option}");
        print("the value is :: ${requiredParam.specValues[i].value}");
      }

      return true;
    }
  }

  Widget addImage(GetAllTypeApi getAllTypeApi) {
    return ListImage(
      propertyImages: requiredParam.propertyImages,
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade200,
      elevation: 0,
      centerTitle: true,
      title: titleWidget,
      leading: Container(width: 1,),
    );
  }

  Widget titleWidget = Text(
    "Add Property",
    style: TextStyle(fontSize: 20, color: Colors.black54),
  );

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////TODO Countries


  checkData(PropertyProvider propertyProvider){
    if(propertyProvider.address == "")
      showMessage("الرجاء اختيار المنطقة");
    else if(propertyProvider.useType == "")
      showMessage("الرجاء اختيار نوع العقار");
    else if(double.parse(requiredParam.priceController.text) == 0.0)
      showMessage("الرجاء ادخال السعر");
    else if(int.parse(requiredParam.spaceController.text) == 0)
      showMessage("الرجاء ادخال المساحة");
    else{
      _pageController.nextPage(duration: Duration(
          milliseconds: 800
      ), curve: Curves.easeIn);
    }
  }

  showDataCountries(PropertyProvider provider)
  {
    return BlocBuilder<CountryBloc,CountryState>(
      cubit: BlocProvider.of<CountryBloc>(context),
      builder: (context,state){
        if (state is Wait)
          return Center(
              child: CupertinoActivityIndicator(
                radius: 10,
                animating: true,
              ));
        else if (state is FetchAllCountry)
          return ListView.builder(
              itemCount: state.countryModel.data.length,
              shrinkWrap: true,
              itemBuilder:(context,index){
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.countryModel.data[index].cities.length,
                    itemBuilder: (context,position){
                      return ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return Divider(
                              indent: 10,endIndent: 20,
                            );
                          },
                          itemCount: state.countryModel.data[index].cities[position].areas.length,
                          itemBuilder: (context,indexArea){
                            return InkWell(
                              onTap: (){
                                requiredParam.isVal.value = false;
                                requiredParam.title.value = state.countryModel.data[index].cities[position].areas[indexArea].name;
                                requiredParam.areaId = state.countryModel.data[index].cities[position].areas[indexArea].id;
                                requiredParam.address = requiredParam.title.value;
                                requiredParam.colorTextCountry.value = colorApp;
                                provider.setAreaIdValue(requiredParam.areaId);
                                provider.setAddressValue(requiredParam.address);
                                print("areaId ${provider.areaId}");
                                print("area id ${provider.areaId} address ${provider.address}");
                              },
                              child: Container(
                                child: Text(state.countryModel.data[index].cities[position].areas[indexArea].name),
                              ),
                            );
                          });
                    });
              });
        else if(state is FailedGetAllCountries)
          return Column(
            children: <Widget>[
              Text("No internet connection"),
              IconButton(
                icon: Icon(Icons.restore),
                onPressed: (){
//                  BlocProvider.of<AddProperetyDartBloc>(context)..add(GetAllCountry());
                },
              ),
            ],
          );
        return Container(
          width: 100,height: 100,color: Colors.green,
        );
      },
    );
  }



  //////////////////////////////////////////////////////////////////////////////////////////////////////////////TODO map
  Widget showMap(PropertyProvider propertyProvider){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: EdgeInsets.only(left: 15,right: 15),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("يمكنك اختيار موقع العقار",style: TextStyle(color: Colors.black54),),
                  InkWell(
                      onTap:requiredParam.markers.length !=0 ? null : (){
                        print("onPressed");
                        _getCurrentLocation(propertyProvider);
                      },
                      child: Text("الحصول على موقعي",style: TextStyle(color: colorApp,fontWeight: FontWeight.w600),))
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  myLocationEnabled: requiredParam.isLocationEnable,
                  zoomControlsEnabled: false,
                  markers: Set<Marker>.of(requiredParam.markers.values),
                  mapType: requiredParam.mapType,
                  initialCameraPosition: requiredParam.kGooglePlex,
                  onLongPress: (val){
                    print(val);
                    _add(val,propertyProvider);
                  },
                  onMapCreated: (GoogleMapController controller) {
                    requiredParam..mapController.complete(controller);
                  },
                ),
              ),
              Positioned.fill(
                bottom: 5,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: "alsjdhaslkdmas",
                          onPressed: (){
                            setState(() {
                              requiredParam.mapType = MapType.satellite;
                            });
                          },
                          child: Icon(Icons.filter_hdr),
                          mini: true,
                        ),
                        SizedBox(width: 5,),
                        FloatingActionButton(
                          heroTag: "aslkfcaslkm",
                          onPressed: (){
                            setState(() {
                              requiredParam.mapType =MapType.normal;
                            });
                          },
                          mini: true,
                          child: Icon(Icons.satellite),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _add(latLang,PropertyProvider propertyProvider) {

    final int markerCount = requiredParam.markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_${requiredParam.markerIdCounter}';
    requiredParam.markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
        markerId: markerId,
        position:latLang ,
        onTap: (){
          setState(() {
            requiredParam.markers.clear();
          });
        }
    );

    setState(() {
      requiredParam.markers.clear();
      requiredParam.markers[markerId] = marker;
      requiredParam.isLocationEnable = false;
      propertyProvider.setLongitudeValue(latLang.longitude);
      propertyProvider.setLatitudeValue(latLang.latitude);
    });

  }

  _getCurrentLocation(PropertyProvider propertyProvider) async{
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    await  geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest)
        .then((Position position) async{
      setState(() {
        requiredParam.isLocationEnable =true;
        requiredParam.kGooglePlex = CameraPosition(
          target: LatLng(	position.latitude, position.longitude),
          zoom: 17.0,);
        print("position $position");
      });
      propertyProvider.setLongitudeValue(position.longitude);
      propertyProvider.setLatitudeValue(position.latitude);
      final GoogleMapController controller = await requiredParam.mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(requiredParam.kGooglePlex));
    }).catchError((e) {
      print("error $e");
    });
  }
  addPropertyAction(PropertyProvider propertyProvider)async {
    await AddPropertyApi.addProperty(typeId: [1,5], areaId:propertyProvider.areaId ,
        address: propertyProvider.address, price: propertyProvider.price, img: requiredParam.propertyImages[0],
        space: propertyProvider.space, useType: propertyProvider.useType,postalCode: propertyProvider.postalCode,
        images: requiredParam.propertyImages, specs: requiredParam.specValues,
        longitude: propertyProvider.longitude,latitude: propertyProvider.latitude
    );

  }
}



class ShowCollapseCountry extends StatelessWidget {
  ValueNotifier<String> title;
  Widget body;
  ValueNotifier<bool> isShowItems;
  Widget icon;
  bool showBorder;
  EdgeInsets padding;
  Color color;

  ShowCollapseCountry({@required this.title,@required this.body, this.isShowItems, this.icon,
    this.showBorder, this.padding , this.color});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isShowItems,
      builder: (context,_,__){
        return Collapse(
          body: body??Container(),
          onChange: (val){
            isShowItems.value = val;
          },
          showBorder: showBorder ?? false,
          icon: icon,
          value: isShowItems.value,
          padding: padding,
          title: Text(title.value,style: TextStyle(color: color)),
        );
      },
    );
  }
}
