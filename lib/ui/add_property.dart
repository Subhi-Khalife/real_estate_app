import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/widget/collapse.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class AddProperty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProperty();
  }
}

class _AddProperty extends State<AddProperty> {
  int typeId;
  String first = "";
  List<TextEditingController> _controller = [];
  TextEditingController proprtyController = TextEditingController();
  int randomValueCard = 100;
  int select, houseIndex = 0;
  List<String> collapse = List();
  Map<int,List<int> >specID={};
  @override
  void initState() {
    super.initState();
    proprtyController.text = "";

    for (int i = 0; i < 70; i++) {
      _controller.add(TextEditingController());
      collapse.add("");
      specID[i]=[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            addImage(),
            showCollapse(0, "نوع العقار "),
          ],
        ),
      ),
    );
  }

  Widget showCollapse(int, String title) {
    return BlocBuilder<AddProperetyDartBloc, AddProperetyDartState>(
      cubit: BlocProvider.of<AddProperetyDartBloc>(context),
      builder: (context, AddProperetyDartState state) {
        if (state is Wait) {
          return isLoading();
        } else if (state is InsertAllPropertyType) {
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
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
        } else {
          return Container();
        }
      },
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

  Widget addImage() {
    return GestureDetector(
      onTap: () {
        for (int i = 0; i <= 4; i++) {
          print("the values is ::${_controller[i].text}");
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Card(
            child: Center(
              child: SvgPicture.asset(
                "svg/add_img_icon.svg",
                height: 20,
                width: 20,
              ),
            ),
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
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
