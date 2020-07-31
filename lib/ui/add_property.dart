import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/show_message.dart';

class AddProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProperty();
  }
}

class _AddProperty extends State<AddProperty> {
  int typeId = -1;
  String first = "";
  List<TextEditingController> _controller = [];
  TextEditingController proprtyController = TextEditingController();
  int randomValueCard = 100;
  int select, houseIndex = 0;
  List<String> collapse = List();
  Map<int, List<int>> specID = {};
  @override
  void initState() {
    super.initState();
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
              addImage(state.type),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CollapseView(
                  title: "نوع العقار",
                  getAllTypeApi: state.type,
                  index: 0,
                  values: collapse,
                  first: first,
                  textEditingController: proprtyController,
                  houseTypeIndex: houseIndex,
                  typeId: typeId,
                ),
              ),
              (state.index != -1)
                  ? showOtheInfo(state.type, state.index)
                  : Container()
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
                padding: const EdgeInsets.all(8.0),
                child: CollapseView(
                  title: "نوع العقار",
                  getAllTypeApi: items,
                  index: index + 1,
                  specID: specID,
                  values: collapse,
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
      return true;
    }
  }

  Widget addImage(GetAllTypeApi getAllTypeApi) {
    return GestureDetector(
      onTap: () {
        if (checkFields(getAllTypeApi))
          showMessage('جميع المعلةمات مدخلة بشكل صحيح ');
      },
      child: Padding(
        padding: EdgeInsets.only(top: 14),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Card(
              child: Center(
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: colorApp,
                ),
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
        ),
      ),
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
