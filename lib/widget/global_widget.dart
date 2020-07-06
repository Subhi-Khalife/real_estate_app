import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projects/widget/color_app.dart';

class ShowImage extends StatelessWidget {
  final String assetName;

  final double height, width;

  final BoxFit boxFit;

  ShowImage(this.assetName,
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
  final Function onChange;
  final Color colorIcon;

  TextFieldApp(
      {@required this.controller,
      this.focusNode,
      this.onSubmitted,
      this.textInputAction,
      this.labelText,
      this.icon,
      this.isLookAtPassword = false,
      this.onPressedLookAtPassword,
      @required this.isTextFieldPassword,
        this.onChange,
        this.colorIcon
      });

  @override
  Widget build(BuildContext context) {
    return isTextFieldPassword
        ? TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style:
                TextStyle(color: activeIconNavBar, fontFamily: "regular", fontSize: 16),
            cursorColor: activeIconNavBar,
            obscureText: !isLookAtPassword,
            onChanged: onChange,
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
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colorIcon ?? colorGrey,
                      size: 18),
                  onPressed: onPressedLookAtPassword,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  gapPadding: 5.0,
                  borderSide: BorderSide(color: activeIconNavBar, width: 2)),
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
                TextStyle(color: activeIconNavBar, fontFamily: "regular", fontSize: 16),
            cursorColor: activeIconNavBar,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: colorGrey, fontFamily: "regular", fontSize: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: BorderSide(color: activeIconNavBar, width: 2),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0)),
              focusColor: Colors.white,
              hoverColor: Colors.white,
              fillColor: Colors.white,
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
  final String imageUrl;
  final double height;
  final double width;

  ImageCard(
      {@required this.imageUrl, @required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: activeIconNavBar),
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
          color: Colors.grey.shade400, borderRadius: BorderRadius.circular(45)),
      margin: EdgeInsets.only(left: 3, right: 3),
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

  TextFieldSearch({
    @required this.controller,
    this.onSubmitted,
    this.textInputAction,
    this.hintText,
    this.icon,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        controller: controller,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        style: TextStyle(color: activeIconNavBar, fontFamily: "regular", fontSize: 16),
        cursorColor: activeIconNavBar,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15),
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.black, fontFamily: "regular", fontSize: 14),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(Icons.search, color: colorGrey, size: 18),
              onPressed: onSearch,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: activeIconNavBar, width: 2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          fillColor: Colors.teal,
          focusColor: Colors.teal,
          hoverColor: Colors.teal,
        ),
      ),
    );
  }
}

class ButtonApp extends StatelessWidget {
  final Function onPressed;
  final Color colorButton;
  final Color colorText;
  final String textButton;
  final double heightButton;
  final double widthButton;

  ButtonApp(
  {@required this.onPressed, this.colorButton, this.colorText,@required this.textButton,this.heightButton,this.widthButton });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 5.0,
      color: colorButton ?? activeIconNavBar,
      child: Text(textButton , style:  TextStyle(color: colorText ?? Colors.white,fontSize: 18,letterSpacing: 1.2),),
      height: heightButton ?? 40,
      splashColor: Colors.grey.withOpacity(0.6),
    );
  }
}
