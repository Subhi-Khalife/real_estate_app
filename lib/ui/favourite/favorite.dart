import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/house_detail.dart';
import 'package:real_estate_app/widget/card_info.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding:  EdgeInsets.only(top: 10.0),
        child: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HouesDetail()));
                    },
                    child: PropertyCardInformation());
              },
              itemCount: 5,
            )),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: false,
      title: Text("Favorite property",style: TextStyle(
          fontSize: 20,color: Colors.black54
      ),),
      actions: <Widget>[
        Transform.translate(
          offset: Offset(5,20),
          child: Text("Sort",style: TextStyle(
              fontSize: 16,color: Colors.black45
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4,right: 4),
          child: IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.black45,
              ),
              onPressed: () {}),
        ),
      ],
    );
  }
}
