import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/ui/add_properity/required_param.dart';
import 'package:real_estate_app/ui/add_properity/spec_values.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/list_image.dart';
import 'package:real_estate_app/widget/show_message.dart';

class AddPropertySpecAndImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPropertySpecAndImage();
  }
}

class _AddPropertySpecAndImage extends State<AddPropertySpecAndImage> {
  RequiredParam requiredParam;
  @override
  void initState() {
    super.initState();
    requiredParam = RequiredParam();
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
                  } else {
                    showMessage("حدث خطا في الإدخال");
                  }
                },
                color: colorApp,
                child: Text(
                  "Next",
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
