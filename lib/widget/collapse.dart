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
  String first;
  GetAllTypeApi getAllTypeApi;
  int typeId;
  int houseTypeIndex = 0;
  Map<int, List<int>> specID;
  TextEditingController textEditingController;
  CollapseView(
      {this.title,
      this.specID,
      this.first,
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
  int randomValueCard = 0;
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
    if ((widget.first == "" && widget.index == 0)) {
      print("21");
      print('the first Value :: ${widget.first}');
      return showTitle("نوع العقار");
    } else if ((widget.first != "" && widget.index == 0)) {
      print("2");
      return showTitle('${widget.first}');
    } else if (((widget.values[widget.index - 1] == "" && widget.index != 0)) ||
        widget.getAllTypeApi.data[widget.houseTypeIndex]
                .typeSpecs[widget.index - 1].hasMultipleOption ==
            false) {
      return showTitle(
          "${widget.getAllTypeApi.data[widget.houseTypeIndex].typeSpecs[widget.index - 1].name}");
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
                  return GestureDetector(
                    onTap: () {
                      print("ok");
                      setState(() {
                        if (widget.index == 0) {
                          widget.typeId = widget.getAllTypeApi.data[index].id;
                          widget.textEditingController.text =
                              widget.getAllTypeApi.data[index].name;
                          widget.houseTypeIndex = index;

                          widget.first = widget.getAllTypeApi.data[index].name;
                          print("the first value is ::${widget.first}");
                        }
                        if (widget.index != 0) {
                          widget.textEditingController.text = widget
                              .getAllTypeApi
                              .data[widget.houseTypeIndex]
                              .typeSpecs[widget.index - 1]
                              .typeOptions[index]
                              .name;

                          widget.values[widget.index - 1] = widget
                              .getAllTypeApi
                              .data[widget.houseTypeIndex]
                              .typeSpecs[widget.index - 1]
                              .typeOptions[index]
                              .name;
                        }
                        if (widget.index != 0) {
                          List<int> items = widget.specID[widget.index];
                          print(
                              "test ${widget.getAllTypeApi.data[widget.houseTypeIndex].typeSpecs[index].hasMultipleOption}");
                          if (widget.getAllTypeApi.data[widget.houseTypeIndex]
                                  .typeSpecs[index].hasMultipleOption ==
                              true) {
                            print("inside one");
                            items = [];
                            items.add((widget
                                .getAllTypeApi
                                .data[widget.houseTypeIndex]
                                .typeSpecs[index]
                                .id));
                            widget.specID[widget.index] = items;
                          } else {
                            int y = 0;
                            print("inside two");
                            if (items.contains((widget
                                .getAllTypeApi
                                .data[widget.houseTypeIndex]
                                .typeSpecs[index]
                                .id))) {
                              for (int i = 0; i < items.length; i++) {
                                print("the length is :: ${items.length}");
                                if (items[i] ==
                                    widget
                                        .getAllTypeApi
                                        .data[widget.houseTypeIndex]
                                        .typeSpecs[index]
                                        .id) {
                                  items.removeAt(i);
                                  y = 1;
                                  print(
                                      "the length is  afttter:: ${items.length}");
                                } else if (i == items.length - 1 && y == 0) {
                                  print("okkkk");
                                  items.add(widget
                                      .getAllTypeApi
                                      .data[widget.houseTypeIndex]
                                      .typeSpecs[index]
                                      .id);
                                }
                              }
                            } else {
                              items.add(widget
                                  .getAllTypeApi
                                  .data[widget.houseTypeIndex]
                                  .typeSpecs[index]
                                  .id);
                            }
                            widget.specID[widget.index] = items;
                          }
                          setState(() {
                            print("okkkk222");

                            values = items;
                          });
                        }
                        //                        if (randomValueCard == widget.index)
//                          randomValueCard = 100;
//                        else {
//                          randomValueCard = widget.index;
//                        }
                      });

                      if (widget.index != 0) {
                        widget.values[widget.index - 1] = widget
                            .getAllTypeApi
                            .data[widget.houseTypeIndex]
                            .typeSpecs[widget.index - 1]
                            .typeOptions[index]
                            .name;
                      }
                      if (widget.index == 0) {
                        BlocProvider.of<AddProperetyDartBloc>(context)
                          ..add(ShowSpecEvent(index, widget.getAllTypeApi));
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            (widget.index == 0)
                                ? widget.getAllTypeApi
                                    .data[widget.houseTypeIndex].name
                                : widget
                                    .getAllTypeApi
                                    .data[widget.houseTypeIndex]
                                    .typeSpecs[widget.index - 1]
                                    .typeOptions[index]
                                    .name,
                            style: TextStyle(color: Colors.black),
                          ),
                          (widget.index != 0)
                              ? Checkbox(
                                  value: values.contains((widget
                                      .getAllTypeApi
                                      .data[widget.houseTypeIndex]
                                      .typeSpecs[index]
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
                    : widget.getAllTypeApi.data[widget.houseTypeIndex]
                        .typeSpecs[widget.index - 1].typeOptions.length)),
        value: (randomValueCard == widget.index) ? true : false,
        onChange: (bool value) {
          setState(
            () {
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
/*
Checkbox(
                                value: invite[index],
                                activeColor: Colors.white,
                                checkColor: fontMainColor,
                                onChanged: (bool value) {},
                              )
 */
