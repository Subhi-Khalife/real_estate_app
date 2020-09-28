import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/bloc/favourits/favourits_bloc.dart';
import 'package:real_estate_app/bloc/news_bloc/news_bloc.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'package:real_estate_app/ui/house_details/house_details_param.dart';
import 'package:real_estate_app/ui/house_details/house_details_view.dart';
import 'package:real_estate_app/widget/card_info.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FavouritsBloc>(context)..add(GetAllFavouritEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Container(
            child: BlocBuilder<FavouritsBloc, FavouritsState>(
              cubit: BlocProvider.of<FavouritsBloc>(context),
              builder: (context, FavouritsState state) {
                if (state is LoadingFavDataState) {
                  print("2222222222222222");
                  return isLoading();
                } else if (state is GetAllFavouritsState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Property  property=state.datum.data[index].property;
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
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: PropertyCardInformation(
                              space: state.datum.data[index].property.space.toString(),
                              description: state.datum.data[index].property.description.toString(),
                              price: state.datum.data[index].property.price.toString(),
                              address: state.datum.data[index].property.address.toString(),
                              img: state.datum.data[index].property.img.toString(),
                              type: state.datum.data[index].property.useType.toString(),

                            ),
                          ));
                    },
                    itemCount:  state.datum.data.length,
                  );
                } else if (state is ErrorFavState) {
                  print("3333333333333");

                  return errorScreen();
                } else {
                  print("444444444444");

                  return Container();
                }
              },
            )),
      ),
    );
  }

  Widget errorScreen() {
    return InkWell(
      onTap: () {
        BlocProvider.of<NewsBloc>(context)..add(GetAllNewsEvent());
      },
      child: Center(
        child: Text("فشلت العملية الرجاء اعداة المحاولة "),
      ),
    );
  }

  Widget isLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: false,
      actions: <Widget>[
        Transform.translate(
          offset: Offset(0, 15),
          child: Text(
            "الاحدث",
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
        SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
