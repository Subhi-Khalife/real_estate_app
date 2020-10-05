import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/filter_provider.dart';
import 'package:real_estate_app/Provider/house_category_provider.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'package:real_estate_app/ui/house_details/house_details_param.dart';
import 'package:real_estate_app/ui/house_details/house_details_view.dart';
import 'package:real_estate_app/widget/card_info.dart';
import 'package:real_estate_app/widget/color_app.dart';

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
    housesCategoryProvider =
        Provider.of<HousesCategoryProvider>(context, listen: false);
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
              return showInfo(state.types);
            } else if (state is SetHouseValuesFilter) {
              return showFilterInfo(state.types);
            } else if (state is ErrorState) {
              return error();
            }
            return Container();
          }),
    );
  }

  Widget showFilterInfo(Data items) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<ExploreDartBloc>(context)
                ..add(LoadingExploreData(context));
              housesCategoryProvider.addValues(items);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "الغاء الفلترة",
                    style: TextStyle(color: colorApp, fontSize: 16),
                  ),
                  Icon(
                    Icons.clear,
                    color: colorApp,
                  )
                ],
              ),
            ),
          ),
          showInfo(items)
        ],
      ),
    );
  }

  Widget showInfo(Data state) {
    housesCategoryProvider.addValues(state);
    return Consumer<HousesCategoryProvider>(builder: (context, values, _) {
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
                      Property property = values.list[index][index2];
                      return InkWell(
                        onTap: () {
                          HouseDetails houseDetails = HouseDetails(
                            location: "property.area.cityName",
                            isFavourit: property.isFavorite,
                            areaCityAddress: property.area.cityName,
                            areaCityName: property.area.name,
                            phone: property.user.phone,
                            email: property.user.email,
                            description: property.description,
                            price: property.price.toString(),
                            image: property.img,
                            property: property,
                            properityId: property.id.toString(),
                          );
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HouesDetailFavourits(
                              houseDetails: houseDetails,
                            ),
                          ));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .38,
                          width: MediaQuery.of(context).size.width * .9,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 0),
                            child: PropertyCardInformation(
                              img: property.img,
                              address: property.address,
                              price: property.price.toString(),
                              description: property.description,
                              space: property.space.toString(),
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
}
