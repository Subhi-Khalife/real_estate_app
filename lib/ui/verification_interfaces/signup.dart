import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/Api/signup_api.dart';
import 'package:real_estate_app/ui/MainView.dart';
import 'package:real_estate_app/ui/explore/explore.dart';
import 'package:real_estate_app/ui/map_view.dart';
import 'package:real_estate_app/ui/verification_interfaces/login.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/show_message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController _emailController,
      _passwordController,
      _passwordConfirmController,
      _firstNameController,
      _lastNameController,
      _phoneNumberController,
      _birthdayController,
      _cityController;
  bool isLockPassword = false;
  bool isLockConfirmPassword = false;
  bool isCheck = false;
  bool checkLengthPassword = false, checkLengthConfirmPassword = false;
  FocusNode _passwordFocus = FocusNode(),
      _passwordConfirmFocus = FocusNode(),
      _firstNameFocus = FocusNode(),
      _lastNameFocus = FocusNode(),
      _phoneNumberFocus = FocusNode(),
      _emailFocus = FocusNode();
  Color colorIconPass = colorGrey;
  Color colorIconPassConfirm = colorGrey;
  // final facebookSignUp = FacebookLogin();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _birthdayController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print("hei $height");
    return Scaffold(
      backgroundColor: backgroundColorScaffold,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: LogInTitle(
                title: "إنشاء حساب",
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: 0.1,
                                child: ShowImage(
                                  "svg/Login-rafiki.svg",
                                  height: height * 0.5,
                                  boxFit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: TextFieldApp(
                                    controller: _lastNameController,
                                    isTextFieldPassword: false,
                                    labelText: "الأسم الأخير *",
                                    textInputAction: TextInputAction.next,
                                    focusNode: _lastNameFocus,
                                    onSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(_phoneNumberFocus);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextFieldApp(
                                    controller: _firstNameController,
                                    isTextFieldPassword: false,
                                    textInputAction: TextInputAction.next,
                                    focusNode: _firstNameFocus,
                                    labelText: "الاسم الأول *",
                                    onSubmitted: (val) {
                                      FocusScope.of(context)
                                          .requestFocus(_lastNameFocus);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            TextFieldApp(
                              controller: _phoneNumberController,
                              isTextFieldPassword: false,
                              focusNode: _phoneNumberFocus,
                              inputFormatter: [
                                WhitelistingTextInputFormatter(RegExp("[0-9]"))
                              ],
                              labelText: "رقم الموبايل",
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              onSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocus);
                              },
                            ),
                            SizedBox(height: 15),
                            TextFieldApp(
                              controller: _emailController,
                              isTextFieldPassword: false,
                              labelText: "البريد الإلكتروني *",
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _emailFocus,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                            ),
                            // SizedBox(height: 15),
                            // InkWell(
                            //   onTap: () {
                            //     if (_birthdayController.text.trim() == "")
                            //       _birthdayController.text =
                            //           parseToDateTime(DateTime.now());
                            //     showModalBottomSheet(
                            //         context: context,
                            //         isScrollControlled: true,
                            //         isDismissible: false,
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.only(
                            //                 topRight: Radius.circular(15.0),
                            //                 topLeft: Radius.circular(15.0))),
                            //         builder: (context) {
                            //           return selectDate();
                            //         });
                            //   },
                            //   child: TextFieldApp(
                            //     controller: _birthdayController,
                            //     isTextFieldPassword: false,
                            //     labelText: "تاريخ الميللاد",
                            //     isEnable: false,
                            //     onSubmitted: (val) {
                            //       FocusScope.of(context)
                            //           .requestFocus(_passwordFocus);
                            //     },
                            //     icon: Icons.date_range,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     showDialog(
                            //         context: context,
                            //         barrierDismissible: false,
                            //         builder: (context) => dialogCity([
                            //               "Aleppo",
                            //               "Homs",
                            //               "Idleb",
                            //               "Damascus",
                            //               "Lattakia",
                            //               "Tartous",
                            //               "Raqqa",
                            //               "Deir Al-Zour",
                            //               "Hasaka",
                            //               "Daraa",
                            //               "Al-Suwayda",
                            //               "Hamah"
                            //             ]));
                            //   },
                            //   child: TextFieldApp(
                            //     controller: _cityController,
                            //     isTextFieldPassword: false,
                            //     labelText: "المدينة",
                            //     onSubmitted: (val) {
                            //       FocusScope.of(context)
                            //           .requestFocus(_passwordFocus);
                            //     },
                            //     icon: Icons.arrow_drop_down,
                            //     isEnable: false,
                            //   ),
                            // ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldApp(
                              controller: _passwordController,
                              isTextFieldPassword: true,
                              focusNode: _passwordFocus,
                              labelText: "كلمة السر *",
                              textInputAction: TextInputAction.next,
                              isLengthSmall: checkLengthPassword,
                              maxLength: 16,
                              colorIcon: colorIconPass,
                              onChange: (val) {
                                if (val.toString().trim() != "")
                                  setState(() {
                                    colorIconPass = activeIconNavBar;
                                  });
                                else
                                  setState(() {
                                    colorIconPass = colorGrey;
                                  });
                                if (val.toString().length >= 4)
                                  setState(() {
                                    checkLengthPassword = false;
                                  });
                                else
                                  setState(() {
                                    checkLengthPassword = true;
                                  });
                              },
                              onSubmitted: (val) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordConfirmFocus);
                              },
                              isLookAtPassword: isLockPassword,
                              onPressedLookAtPassword: () {
                                setState(() {
                                  isLockPassword = !isLockPassword;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldApp(
                              controller: _passwordConfirmController,
                              isTextFieldPassword: true,
                              textInputAction: TextInputAction.go,
                              focusNode: _passwordConfirmFocus,
                              labelText: "تأكيد كلمة السر",
                              maxLength: 16,
                              isLengthSmall: checkLengthConfirmPassword,
                              colorIcon: colorIconPassConfirm,
                              onChange: (val) {
                                if (val.toString().trim() != "")
                                  setState(() {
                                    colorIconPassConfirm = activeIconNavBar;
                                  });
                                else
                                  setState(() {
                                    colorIconPassConfirm = colorGrey;
                                  });
                                if (val.toString().length >= 4)
                                  setState(() {
                                    checkLengthConfirmPassword = false;
                                  });
                                else
                                  setState(() {
                                    checkLengthConfirmPassword = true;
                                  });
                              },
                              onSubmitted: (val) {
                                onSignUp();
                              },
                              isLookAtPassword: isLockConfirmPassword,
                              onPressedLookAtPassword: () {
                                setState(() {
                                  isLockConfirmPassword =
                                      !isLockConfirmPassword;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ButtonApp(
                                onPressed: onSignUp,
                                textButton: "إنشاء حساب",
                                colorButton: Colors.indigo.shade900,
                                heightButton: 50,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width,
                            //   child: ButtonApp(
                            //     onPressed: (){
                            //
                            //     },
                            //     textButton: "إنشاء حساب مع فيسبوك",
                            //     colorButton: activeIconNavBar,
                            //     heightButton: 50,
                            //   ),
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView()),
                                                (route) => false);
                                      },
                                      child: Text(
                                        "تسجيل الدخول ",
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Colors.indigo.shade900
                                                .withOpacity(0.7)),
                                      ),
                                    ),
                                    Text(
                                      "هل متأكد أنك تملك حساب؟ ",
                                      style: TextStyle(
                                          color: Colors.indigo.shade900
                                              .withOpacity(0.7)),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String parseToDateTime(DateTime time) {
    return "${time.year}/${time.month}/${time.day}";
  }

  Widget dialogCity(List<String> cities) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            "All City",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
                itemCount: cities.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black45,
                    endIndent: 10,
                    indent: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _cityController.text = cities[index];
                      Navigator.pop(context);
                    },
                    title: Text(
                      cities[index],
                      style: TextStyle(
                        color: colorApp,
                        fontSize: 17,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget selectDate() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Select Date",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (dateTime) {
                  print("date Time $dateTime}");
                  _birthdayController.text = parseToDateTime(dateTime);
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20.0),
            child: ButtonApp(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textButton: "Apply",
            ),
          ),
        ],
      ),
    );
  }

  onSignUp() {
    if (_firstNameController.text.trim() == "")
      showMessage("Please Enter first name");
    else if (_lastNameController.text.trim() == "")
      showMessage("Please Enter last name");
    else if (_emailController.text.trim() == "")
      showMessage("Please Enter email");
    else if (_passwordController.text.trim() == "")
      showMessage("Please Enter password");
    else if (_passwordController.text.trim().length < 4)
      showMessage("Please Enter password 4 character at least ");
    else if (_passwordConfirmController.text.trim().length < 4)
      showMessage("Please Enter confirm password 4 character at least");
    else if (_passwordController.text.trim() !=
        _passwordConfirmController.text.trim())
      showMessage("Please check password equal confirm password ");
    else {
      print('_phoneNumberController.text ${_phoneNumberController.text}');
      SignUpApi.signUpRequest(context,
              firstName: _firstNameController.text,
              phoneNumber: _phoneNumberController.text,
              lastName: _lastNameController.text,
              email: _emailController.text.trim(),
              password: _passwordController.text,
              birthDay: _birthdayController.text ?? "",
              cityName: _cityController.text ?? "")
          .then((value) {
        if (value != null) {
          if (value.status == "OK")
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => MainView()),
                (Route ee) => false);
        }
        return null;
      });
    }
  }

  // onSignUpFacebook() async {
  //   final FacebookLoginResult result =
  //       await facebookSignUp.logInWithReadPermissions(['email']);
  //   final token = result.accessToken.token;
  //   final graphResponse = await http.get(
  //       'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  //   final profile = JSON.json.decode(graphResponse.body);
  // }
}
