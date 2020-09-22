import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/filter_provider.dart';
import 'package:real_estate_app/Provider/house_category_provider.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/ui/house_detail.dart';
import 'package:real_estate_app/widget/card_category_just_in.dart';
import 'package:real_estate_app/widget/card_designer_home.dart';
import 'package:real_estate_app/widget/card_info.dart';
import 'package:real_estate_app/widget/global_text.dart';

class HousesCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HousesCategory();
  }
}

class _HousesCategory extends State<HousesCategory> {
  FilterProvider _filterProvider;
  HousesCategoryProvider housesCategoryProvider;
  @override
  void initState() {
    super.initState();
    _filterProvider = Provider.of<FilterProvider>(context, listen: false);
    housesCategoryProvider =   Provider.of<HousesCategoryProvider>(context, listen: false);
    // BlocProvider.of<ExploreDartBloc>(context)..add(LoadingExploreData(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExploreDartBloc, ExploreDartState>(
          cubit: BlocProvider.of<ExploreDartBloc>(context),
          builder: (context, state) {
            if (state is LoadingState) {
              return loadingInfo();
            } else if (state is SetHouseValuesState) {
              housesCategoryProvider.addValues(state.props[0]);
              return Consumer<HousesCategoryProvider>(
                  builder: (context, values, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 22,
                            ),
                            child: Text(
                              "${values.list[index][0].type.name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .38,
                            width: MediaQuery.of(context).size.width * .9,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HouesDetail(
                                          properties: state
                                              .types.properties.data[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .38,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 0),
                                      child: PropertyCardInformation(
                                        img: state
                                            .types.properties.data[index].img,
                                        address: state.types.properties
                                            .data[index].address,
                                        price: state
                                            .types.properties.data[index].price
                                            .toString(),
                                        description: state.types.properties
                                            .data[index].description,
                                        space: state
                                            .types.properties.data[index].space
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: values.list[index].length,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: values.list.length,
                );
              });
            } else if (state is ErrorState) {
              return error();
            }
            return Container();
          }),
    );
  }

/*
 return Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HouesDetail(
                                  properties: state.types.properties.data[index],
                                )));
                          },
                          child: PropertyCardInformation(
                            img: state.types.properties.data[index].img,
                            address: state.types.properties.data[index].address,
                            price:
                                state.types.properties.data[index].price.toString(),
                            description:
                                state.types.properties.data[index].description,
                            space:
                                state.types.properties.data[index].space.toString(),
                          ),
                        );
                      },
                      itemCount: state.types.properties.data.length,
                    )),
                  );
 */
  Widget error() {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        BlocProvider.of<ExploreDartBloc>(context)
          ..add(LoadingExploreData(context));
      },
    );
  }

  Widget loadingInfo() {
    return Center(child: CircularProgressIndicator());
  }

  Widget designerHome() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .3,
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HouesDetail()));
                },
                child: CardDesignerHome(images[index]));
          },
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget houseIntoJsutIn() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .45,
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HouesDetail()));
                },
                child: CardJustIn(images[index]));
          },
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  List<String> images = [
    "https://www.antalyahomes.com/picsize.asp?picresize=g/800/457/BLK-097/peaceful-detached-homes-in-secure-villa-complex-in-belek-main.jpg",
    "https://www.theplancollection.com/Upload/Designers/175/1073/Plan1751073MainImage_11_6_2015_13.jpg",
    "https://i.pinimg.com/originals/ff/20/38/ff20382afaafd22e5a72e6b1fc0e74ad.jpg",
    "https://pic.i7lm.com/wp-content/uploads/2020/01/1-45.jpg",
    "https://www.alaraby.co.uk/sites/default/files/media/images/363928F7-03BB-4614-81C2-C3058C2DBED4.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQr6qumlY5b7XJfy3cY1JHAzLoP___hMZKoew&usqp=CAU"
  ];
}
