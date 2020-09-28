import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/filter_provider.dart';
import 'package:real_estate_app/Provider/house_category_provider.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'package:real_estate_app/ui/house_details/house_details_param.dart';
import 'package:real_estate_app/ui/house_details/house_details_view.dart';
import 'package:real_estate_app/widget/card_info.dart';

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
              housesCategoryProvider.addValues(state.types);
              return Consumer<HousesCategoryProvider>(
                  builder: (context, values, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    print("values ${values.list[index].length}");
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: 22,
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
                              itemBuilder: (context, index2) {
                                Property property=values.list[index][index2];
                                return InkWell(
                                  onTap: () {
                                    HouseDetails houseDetails=HouseDetails(
                                      location: "property.area.cityName",
                                      isFavourit: property.isFavorite,
                                      areaCityAddress:property.area.cityName ,
                                      areaCityName: property.area.name,
                                      phone:  property.user.phone,
                                      email:  property.user.email,
                                      description:  property.description,
                                      price:  property.price.toString(),
                                      image:  property.img,
                                      property: property,
                                      properityId:  property.id.toString(),
                                    );
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          HouesDetailFavourits(
                                            houseDetails:houseDetails,
                                          ),
                                    ));
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
                                        img: property.img,
                                        address: property.address,
                                        price: property.price
                                            .toString(),
                                        description: property.description,
                                        space: property.space
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

  List<String> images = [
    "https://www.antalyahomes.com/picsize.asp?picresize=g/800/457/BLK-097/peaceful-detached-homes-in-secure-villa-complex-in-belek-main.jpg",
    "https://www.theplancollection.com/Upload/Designers/175/1073/Plan1751073MainImage_11_6_2015_13.jpg",
    "https://i.pinimg.com/originals/ff/20/38/ff20382afaafd22e5a72e6b1fc0e74ad.jpg",
    "https://pic.i7lm.com/wp-content/uploads/2020/01/1-45.jpg",
    "https://www.alaraby.co.uk/sites/default/files/media/images/363928F7-03BB-4614-81C2-C3058C2DBED4.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQr6qumlY5b7XJfy3cY1JHAzLoP___hMZKoew&usqp=CAU"
  ];
}
