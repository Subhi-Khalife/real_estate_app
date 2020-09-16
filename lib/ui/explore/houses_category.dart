import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/ui/explore/filter_provider.dart';
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
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filterProvider = Provider.of<FilterProvider>(context, listen: false);

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
              // if(_filterProvider.firstTime==false)
              // _filterProvider.filtersValues.add(state.types);
             return Padding(
                padding:  EdgeInsets.only(top: 10.0),
                child: Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => HouesDetail()));
                            },
                            child: PropertyCardInformation(
                              img: state.types.properties.data[index].img,
                              address: state.types.properties.data[index].address,
                              price: state.types.properties.data[index].price.toString(),
                              description: state.types.properties.data[index].description,
                              space: state.types.properties.data[index].space.toString(),
                            ),);
                      },
                      itemCount: state.types.properties.data.length,
                    )),
              );
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
        BlocProvider.of<ExploreDartBloc>(context)..add(LoadingExploreData());
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
                child: CardDesignerHome());
          },
          itemCount: 9,
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
                child: CardJustIn());
          },
          itemCount: 9,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
