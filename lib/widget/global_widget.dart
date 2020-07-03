import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realestateapp/widget/color_app.dart';

class ShowSvg extends StatelessWidget {
  final String assetName;

  final double height, width;

  final BoxFit boxFit;

  ShowSvg(this.assetName,
      {this.height = 25.0, this.width = 25.0, this.boxFit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        height: height, width: width, fit: boxFit);
  }
}

class TextFieldApp extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final TextInputAction textInputAction;
  final String labelText;
  final IconData icon;
  final bool isLookAtPassword;
  final Function onPressedLookAtPassword;
  final bool isTextFieldPassword;

  TextFieldApp(
      {@required this.controller,
      this.focusNode,
      this.onSubmitted,
      this.textInputAction,
      this.labelText,
      this.icon,
      this.isLookAtPassword = false,
      this.onPressedLookAtPassword,
      @required this.isTextFieldPassword});

  @override
  Widget build(BuildContext context) {
    return isTextFieldPassword
        ? TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style:
                TextStyle(color: colorApp, fontFamily: "regular", fontSize: 16),
            cursorColor: colorApp,
            obscureText: !isLookAtPassword,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: colorGrey, fontFamily: "regular", fontSize: 15),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Icon(
                      isLookAtPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: colorGrey,
                      size: 18),
                  onPressed: onPressedLookAtPassword,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  gapPadding: 5.0,
                  borderSide: BorderSide(color: colorApp, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0), gapPadding: 5.0),
            ),
          )
        : TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style:
                TextStyle(color: colorApp, fontFamily: "regular", fontSize: 16),
            cursorColor: colorApp,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: colorGrey, fontFamily: "regular", fontSize: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: BorderSide(color: colorApp, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),),
            ));
  }
}

class LoginButton extends StatelessWidget {
  final Function onPressed;

  final Color colorButton;
  final double height;
  final Color textColor;
  final double fontSize;
  final String textButton;

  LoginButton(
      {@required this.onPressed,
      @required this.colorButton,
      this.height = 30,
      this.textColor = Colors.white,
      this.fontSize = 16,
      @required this.textButton});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: colorButton,
      height: height,
      child: Text(
        textButton,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
      minWidth: MediaQuery.of(context).size.width * 0.9,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl ;
  final double height ;
  final double width ;

  ImageCard({@required this.imageUrl,@required this.height,@required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: colorApp
      ),
    );
  }
}

class DotSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(45)
      ),
      margin: EdgeInsets.only(left: 3,right: 3),
    );
  }
}


class TextFieldSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  final TextInputAction textInputAction;
  final String hintText;
  final IconData icon;
  final Function onSearch;


  TextFieldSearch(
     {@required this.controller,
      this.onSubmitted,
      this.textInputAction,
      this.hintText,
      this.icon,
      this.onSearch,
     });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        style:
        TextStyle(color: colorApp, fontFamily: "regular", fontSize: 16),
        cursorColor: colorApp,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.black, fontFamily: "regular", fontSize: 14),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(
                  Icons.search,
                  color: colorGrey,
                  size: 18),
              onPressed: onSearch,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: colorApp, width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0)),
          fillColor: Colors.teal,
          focusColor: Colors.teal,
          hoverColor: Colors.teal,
        ),
      ),
    );
  }
}



