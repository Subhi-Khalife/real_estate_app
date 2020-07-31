import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate_app/Api/upload_image.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/model/photos_model.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/list_image.dart';
import 'package:real_estate_app/widget/show_message.dart';

class AddProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProperty();
  }
}

class _AddProperty extends State<AddProperty> {
  List<String> propertyImages = [];
  List<int> typeId = [];
  List<String> first =[];
  List<TextEditingController> _controller = [];
  TextEditingController proprtyController = TextEditingController();
  int randomValueCard = 100;
  int select, houseIndex = 0;
  List<String> collapse = List();
  Map<int, List<int>> specID = {};
  @override
  void initState() {
    super.initState();
    typeId.add(-1);
    first.add("نوع العقار");
    proprtyController.text = "";
    for (int i = 0; i < 70; i++) {
      _controller.add(TextEditingController());
      collapse.add("");
      specID[i] = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<AddProperetyDartBloc>(context)..add(LoadingData());
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              showCollapse(0, "نوع العقار "),
            ],
          ),
        ),
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
                  values: collapse,
                  specID: specID,
                  first: first,
                  controller: _controller,
                  textEditingController: proprtyController,
                  houseTypeIndex: houseIndex,
                  typeId: typeId,
                ),
              ),

              (state.index != -1)
                  ? showOtheInfo(state.type, state.index)
                  : Container()
              ,
              MaterialButton(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: (){
                  if(checkFields(state.type)){
                    showMessage("جميع المعلومات صحيحة");
                  }else{
                    showMessage("حدث خطا في الإدخال");

                  }
                },
                color: colorApp,
                child: Text("Next",style: TextStyle(color: Colors.white),),
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
                    controller: _controller[index],
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
                  specID: specID,
                  first: first,

                  values: collapse,
                  controller: _controller,
                  textEditingController: _controller[index],
                  houseTypeIndex: houseIndex,
                ),
              );
      },
      itemCount: items.data[selectedValue].typeSpecs.length,
    );
  }

  bool checkFields(GetAllTypeApi getAllTypeApi) {
    if (typeId == -1) {
      showMessage("قم باختيار نوع العقار المطلوب");
    } else {
      for (int i = 0;
          i < getAllTypeApi.data[houseIndex].typeSpecs.length;
          i++) {
        if (getAllTypeApi.data[houseIndex].typeSpecs[i].hasOption == false &&
            _controller[i].text.trim() == "") {
          showMessage("الرجاء قم بادخال جميع الحقول المطلوبة ");
          return false;
        } else if (getAllTypeApi.data[houseIndex].typeSpecs[i].hasOption ==
                true &&
            getAllTypeApi.data[houseIndex].typeSpecs[i].hasMultipleOption ==
                false &&
            specID[i + 1].length == 0) {
          showMessage("تاكد من ادخال جميع الحقول المطلوبة");
          return false;
        } else if (getAllTypeApi.data[houseIndex].typeSpecs[i].hasOption ==
                true &&
            getAllTypeApi.data[houseIndex].typeSpecs[i].hasMultipleOption ==
                true &&
            specID[i + 1].length == 0) {
          showMessage("تاكد من ادخال جميع الحقول المطلوبة");
          return false;
        }
      }
      if(propertyImages.length==0){
        showMessage("يجب إدخال الصورة الرئيسية للعقار");
        return false;
      }
      else  if(propertyImages.length==1){
        showMessage("يجب إدخال الصورة فرعية واحدة على الاقل");
        return false;
      }
      return true;
    }
  }

  Widget addImage(GetAllTypeApi getAllTypeApi) {
    return ListImage(
      propertyImages: propertyImages,
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: true,
      title: titleWidget,
      leading: null,
    );
  }

  Widget titleWidget = Text(
    "Add Property",
    style: TextStyle(fontSize: 20, color: Colors.black54),
  );
}
