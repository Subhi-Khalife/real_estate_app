import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/color_app.dart';

class LogInTitle extends StatelessWidget {
  final String title;


  LogInTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title , style: TextStyle(fontSize: 30,color: colorTitleLogin,fontWeight: FontWeight.w600,letterSpacing: 1.2),);
  }
}

class TitleListBuilder extends StatelessWidget {
  final String title;
  final String seeAllText;

  final Function onTapSeeAll;

  TitleListBuilder(
      {@required this.title,
        @required this.seeAllText,
        @required this.onTapSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          FlatButton(
            onPressed: onTapSeeAll,
            child: Text(seeAllText,style: TextStyle(color: colorGrey.withOpacity(0.7),fontSize: 17),),
          )
        ],
      ),
    );
  }
}

class PropertyCardDescription extends StatelessWidget {
  final String description ;
  final Color colorDescription ;

  PropertyCardDescription({@required this.description,this.colorDescription});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(description , style: TextStyle(color: colorDescription ?? Colors.black,fontSize: 14,height: 1.4),maxLines: 3,));
  }
}

class PropertyCardPrice extends StatelessWidget {
  final String price ;
  final Color colorPrice ;

  PropertyCardPrice({@required this.price,this.colorPrice});

  @override
  Widget build(BuildContext context) {
    return Text(price , style: TextStyle(color: colorPrice ?? Colors.red,fontSize: 17,fontWeight: FontWeight.w600),);
  }
}

class PageTitle extends StatelessWidget {
  final String title;


  PageTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title , style: TextStyle(fontSize: 22,color: colorTitleLogin,fontWeight: FontWeight.bold),);
  }
}
