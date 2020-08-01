import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_collapse/flutter_collapse.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';

class CollapseView extends StatefulWidget {
  String title;
  List<String> values;
  int index;
  List<String> first;
  List<TextEditingController> controller = [];
  GetAllTypeApi getAllTypeApi;
  List<int> typeId;
  List<int> houseTypeIndex;
  Map<int, List<int>> specID;
  TextEditingController textEditingController;
  CollapseView(
      {this.title,
      this.specID,
      this.first,
      this.controller,
      this.index,
      this.typeId,
      this.values,
      this.getAllTypeApi,
      this.textEditingController,
      this.houseTypeIndex});
  @override
  State<StatefulWidget> createState() {
    return _CollapseView();
  }
}

class _CollapseView extends State<CollapseView> {
  int randomValueCard = -1;
  List<int> values = [];

  @override
  void initState() {
    super.initState();
    if (widget.index != 0) if (widget.index != 0)
      values = widget.specID[widget.index];
  }

  Widget showTitle(String text) {
    return Text(text);
  }

  Widget showText() {
    print("null");
    if ((widget.first[0] == "" && widget.index == 0)) {
    print("1");
      print('the first Value :: ${widget.first[0]}');
      return showTitle("نوع العقار");
    } else if ((widget.first[0] != "" && widget.index == 0)) {
      print("2");
      return showTitle('${widget.first[0]}');
    } else if (((widget.values[widget.index - 1] == "" && widget.index != 0)) ||
        widget.getAllTypeApi.data[widget.houseTypeIndex[0]]
                .typeSpecs[widget.index - 1].hasMultipleOption ==
            true) {

      return showTitle(
          "${widget.getAllTypeApi.data[widget.houseTypeIndex[0]].typeSpecs[widget.index - 1].name}");
    } else {
      return showTitle(widget.values[widget.index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Collapse(
        padding: EdgeInsets.all(0),
        title: showText(),
        body: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        print("ok");
                        setState(() {
                          if (widget.index == 0 ||
                              widget
                                      .getAllTypeApi
                                      .data[widget.houseTypeIndex[0]]
                                      .typeSpecs[widget.index - 1]
                                      .hasMultipleOption ==
                                  false) randomValueCard = -1;
                          if (widget.index == 0) {
                            widget.controller.clear();
                            widget.values.clear();
                            widget.specID.clear();
                            for (int i = 0; i < 70; i++) {
                              widget.controller.add(TextEditingController());
                              widget.values.add("");
                              widget.specID[i] = [];
                            }

                            print("${widget.getAllTypeApi.data[index].id}");
                            widget.typeId[0] =
                                widget.getAllTypeApi.data[index].id;
                            print("the allll l l l ");
                            widget.textEditingController.text =
                                widget.getAllTypeApi.data[index].name;
                            widget.houseTypeIndex[0] = index;
                            print(
                                "the house index is :: ${widget.houseTypeIndex}");
                            widget.first[0] =
                                widget.getAllTypeApi.data[index].name;
                            print("the first value is ::${widget.first[0]}");
                          }
                          if (widget.index != 0) {
                            widget.textEditingController.text = widget
                                .getAllTypeApi
                                .data[widget.houseTypeIndex[0]]
                                .typeSpecs[widget.index - 1]
                                .typeOptions[index]
                                .name;

                            widget.values[widget.index - 1] = widget
                                .getAllTypeApi
                                .data[widget.houseTypeIndex[0]]
                                .typeSpecs[widget.index - 1]
                                .typeOptions[index]
                                .name;
                          }
                          if (widget.index != 0) {
                            List<int> items = widget.specID[widget.index];
                            print(
                                "test ${widget.getAllTypeApi.data[widget.houseTypeIndex[0]].typeSpecs[widget.index - 1].hasMultipleOption}");
                            if (widget
                                    .getAllTypeApi
                                    .data[widget.houseTypeIndex[0]]
                                    .typeSpecs[widget.index - 1]
                                    .hasMultipleOption ==
                                false) {
                              print("inside one");
                              print("inside one2");
                              print(widget
                                  .getAllTypeApi
                                  .data[widget.houseTypeIndex[0]]
                                  .typeSpecs[widget.index - 1]
                                  .typeOptions[index]
                                  .id);
                              items = [];
                              items.add((widget
                                  .getAllTypeApi
                                  .data[widget.houseTypeIndex[0]]
                                  .typeSpecs[widget.index - 1]
                                  .typeOptions[index]
                                  .id));
                              widget.specID[widget.index] = items;
                            } else {
                              int y = 0;
                              print("inside two");
                              if (items.contains((widget
                                  .getAllTypeApi
                                  .data[widget.houseTypeIndex[0]]
                                  .typeSpecs[widget.index - 1]
                                  .typeOptions[index]
                                  .id))) {
                                for (int i = 0; i < items.length; i++) {
                                  print("the length is :: ${items.length}");
                                  if (items[i] ==
                                      widget
                                          .getAllTypeApi
                                          .data[widget.houseTypeIndex[0]]
                                          .typeSpecs[widget.index - 1]
                                          .typeOptions[index]
                                          .id) {
                                    items.removeAt(i);
                                    y = 1;
                                    print(
                                        "the length is  afttter:: ${items.length}");
                                  } else if (i == items.length - 1 && y == 0) {
                                    print("okkkk");
                                    items.add(widget
                                        .getAllTypeApi
                                        .data[widget.houseTypeIndex[0]]
                                        .typeSpecs[widget.index - 1]
                                        .typeOptions[index]
                                        .id);
                                  }
                                }
                              } else {
                                items.add(widget
                                    .getAllTypeApi
                                    .data[widget.houseTypeIndex[0]]
                                    .typeSpecs[widget.index - 1]
                                    .typeOptions[index]
                                    .id);
                              }
                              widget.specID[widget.index] = items;
                            }
                            setState(() {
                              print("okkkk222");

                              values = items;
                            });
                          }
                        });
                        if (widget.index != 0) {
                          widget.values[widget.index - 1] = widget
                              .getAllTypeApi
                              .data[widget.houseTypeIndex[0]]
                              .typeSpecs[widget.index - 1]
                              .typeOptions[index]
                              .name;
                        }
                        if (widget.index == 0) {
                          BlocProvider.of<AddProperetyDartBloc>(context)
                            ..add(ShowSpecEvent(index, widget.getAllTypeApi));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            (widget.index == 0)
                                ? widget.getAllTypeApi.data[index].name
                                : widget
                                    .getAllTypeApi
                                    .data[widget.houseTypeIndex[0]]
                                    .typeSpecs[widget.index - 1]
                                    .typeOptions[index]
                                    .name,
                            style: TextStyle(color: Colors.black),
                          ),
                          (widget.index != 0)
                              ? Checkbox(
                                  value: widget.specID[widget.index].contains(
                                      (widget
                                          .getAllTypeApi
                                          .data[widget.houseTypeIndex[0]]
                                          .typeSpecs[widget.index - 1]
                                          .typeOptions[index]
                                          .id)),
                                  activeColor: Colors.white,
                                  checkColor: Colors.blue,
                                  onChanged: (bool value) {},
                                )
                              : Container()
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: (widget.index == 0)
                    ? widget.getAllTypeApi.data.length
                    : widget.getAllTypeApi.data[widget.houseTypeIndex[0]]
                        .typeSpecs[widget.index - 1].typeOptions.length)),
        value: (randomValueCard == widget.index) ? true : false,
        onChange: (bool value) {
          setState(
            () {
              print("ok12344 ${widget.index}");
              print("the rand val is :: $randomValueCard");
              if (randomValueCard == widget.index)
                randomValueCard = 100;
              else {
                randomValueCard = widget.index;
              }
            },
          );
        },
      ),
    );
  }
}
