import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_app/bloc/favourits/favourits_bloc.dart';
import 'package:real_estate_app/bloc/news_bloc/news_bloc.dart';
import 'package:real_estate_app/model/get_all_favourites_model.dart';
import 'package:real_estate_app/ui/favourite/house_details_favourits.dart';
import 'package:real_estate_app/ui/house_detail.dart';
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
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  HouesDetailFavourits(
                                    properties: state.datum.data[index],
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

/*
 ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HouesDetail()));
                    },
                    child: PropertyCardInformation());
              },
              itemCount: images.length,
            )
 */
  List<String> images = [
    "https://www.antalyahomes.com/picsize.asp?picresize=g/800/457/BLK-097/peaceful-detached-homes-in-secure-villa-complex-in-belek-main.jpg",
    "https://www.theplancollection.com/Upload/Designers/175/1073/Plan1751073MainImage_11_6_2015_13.jpg",
    "https://www.alaraby.co.uk/sites/default/files/media/images/363928F7-03BB-4614-81C2-C3058C2DBED4.jpg",
    "https://pic.i7lm.com/wp-content/uploads/2020/01/1-45.jpg",
    "https://i.pinimg.com/originals/ff/20/38/ff20382afaafd22e5a72e6b1fc0e74ad.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQr6qumlY5b7XJfy3cY1JHAzLoP___hMZKoew&usqp=CAU"
  ];

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: false,
      actions: <Widget>[
//        Transform.translate(
//          offset: Offset(5,20),
//          child: Text("Sort",style: TextStyle(
//              fontSize: 16,color: Colors.black45
//          ),),
//        ),
//        Padding(
//          padding: const EdgeInsets.only(left: 4,right: 4),
//          child: IconButton(
//              icon: Icon(
//                Icons.sort,
//                color: Colors.black45,
//              ),
//              onPressed: () {}),
//        ),
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
