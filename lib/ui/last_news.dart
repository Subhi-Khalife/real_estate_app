import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/bloc/news_bloc/news_bloc.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'package:real_estate_app/ui/house_details/house_details_param.dart';
import 'package:real_estate_app/ui/house_details/house_details_view.dart';
import 'package:real_estate_app/widget/card_info.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsView createState() => _NewsView();
}

class _NewsView extends State<NewsView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewsBloc>(context)..add(GetAllNewsEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Container(
            child: BlocBuilder<NewsBloc, NewsState>(
          cubit: BlocProvider.of<NewsBloc>(context),
          builder: (context, NewsState state) {
            if (state is LoadingDataState) {
              print("2222222222222222");
              return isLoading();
            } else if (state is getAllDataState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Property  property=state.data.properties.data[index];

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
                          space: state.data.properties.data[index].space.toString(),
                          description: state.data.properties.data[index].description,
                          price: state.data.properties.data[index].price.toString(),
                          address: state.data.properties.data[index].address,
                          img: state.data.properties.data[index].img,
                          type: state.data.properties.data[index].type.name,

                        ),
                      ));
                },
                itemCount: (state.data.properties.data.length > 10)
                    ? 10
                    : state.data.properties.data.length,
              );
            } else if (state is Error) {
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
