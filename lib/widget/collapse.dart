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
  int houseTypeIndex = 0;
  TextEditingController textEditingController;
  CollapseView(
      {this.title,
      this.first,
      this.index,
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
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Collapse(
        padding: EdgeInsets.all(0),
        title: Text((widget.first == "" && widget.index == 0)
            ? "نوع العقار"
            : (widget.first != "" && widget.index == 0)
                ? widget.first
                : ((widget.values[widget.index - 1] == "" && widget.index != 0)
                    ? widget.getAllTypeApi.data[widget.houseTypeIndex]
                        .typeSpecs[widget.index - 1].name
                    : widget.values[widget.index - 1])),
        body: Container(
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
                          widget.textEditingController.text =
                              widget.getAllTypeApi.data[index].name;
                          widget.houseTypeIndex = index;
                          widget.first = widget.getAllTypeApi.data[index].name;
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
                        if (randomValueCard == widget.index)
                          randomValueCard = 100;
                        else {
                          randomValueCard = widget.index;
                        }
                      });
                      if (widget.index == 0) {
                      } else {
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
                      child: Text(
                        (widget.index == 0)
                            ? widget
                                .getAllTypeApi.data[widget.houseTypeIndex].name
                            : widget
                                .getAllTypeApi
                                .data[widget.houseTypeIndex]
                                .typeSpecs[widget.index - 1]
                                .typeOptions[index]
                                .name,
                        style: TextStyle(color: Colors.black),
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
