import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:real_estate_app/Api/login_model.dart';
import 'package:real_estate_app/ui/verification_interfaces/signup.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/loading_dialog.dart';
import 'package:real_estate_app/widget/show_message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final facebookLogin = FacebookLogin();
  TextEditingController _emailController, _passwordController;
  bool isLockPassword = false;
  bool isCheck = false;
  FocusNode _passwordFocus = FocusNode();
  Color colorIcon = colorGrey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print("hei $height");
    return Scaffold(
      backgroundColor: backgroundColorScaffold,
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: height * 0.1,
            ),
            ShowImage(
              "svg/Login-bro-1.svg",
              height: height * 0.27,
              boxFit: BoxFit.fitHeight,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: LogInTitle(
                title: "Login",
              ),
            ),
            SizedBox(height: 15),
            TextFieldApp(
              controller: _emailController,
              isTextFieldPassword: false,
              labelText: "Email",
              onSubmitted: (val) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldApp(
              controller: _passwordController,
              isTextFieldPassword: true,
              focusNode: _passwordFocus,
              labelText: "Password",
              colorIcon: colorIcon,
              onChange: (val) {
                if (val.toString().trim() != "")
                  setState(() {
                    colorIcon = activeIconNavBar;
                  });
                else
                  setState(() {
                    colorIcon = colorGrey;
                  });
              },
              onSubmitted: (val) {
                FocusScope.of(context).unfocus();
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
            Transform.translate(
              offset: Offset(-10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: isCheck,
                    activeColor: activeIconNavBar,
                    onChanged: (val) {
                      setState(() {
                        isCheck = val;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(
                        color: Colors.indigo.shade900.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            ButtonApp(
              onPressed: () async {
                if (_passwordController.text.isEmpty)
                  showMessage("Please enter your password");
                else if (_emailController.text.isEmpty)
                  showMessage("Please enter your email");
                else if (_passwordController.text.length < 4 ||
                    _passwordController.text.length > 12)
                  showMessage("Password should between 4 and 12");
                else {
                  await LoginApi.login(
                      _emailController.text, _passwordController.text, context);
                }
              },
              textButton: "Login",
              colorButton: Colors.indigo.shade900,
              heightButton: 50,
            ),
            SizedBox(
              height: 15,
            ),
            ButtonApp(
              onPressed: () {
                _loginWithFB();
              },
              textButton: "Login with Facebook",
              colorButton: activeIconNavBar,
              heightButton: 50,
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => SignInView()),
                          (Route ee) => false);
                    },
                    child: Text(
                      "Don't Have an account ?",
                      style: TextStyle(
                          color: Colors.indigo.shade900.withOpacity(0.7)),
                    ))),
          ],
        ),
      ),
    );
  }

  _loginWithFB() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        print("the token is $token");
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
//          userProfile = profile;
//          _isLoggedIn = true;
        });
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        LoadingDialog loadingDialog = LoadingDialog(context);
        loadingDialog.show(context);
//        SocailLoginApi loginApi = await LoginModel.socialLogin(
//            socialToken: token, provider: "facebook");
        //  userToken=loginApi.data.tokenApi;
        loadingDialog.dismiss(context);
//        if (loginApi.status != "no") {
//          sharedPreferences.setBool('loginDone',true);
//          sharedPreferences.setString('token',loginApi.data.tokenApi.toString());
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) => PageReactiveButton()));
//        }

        break;

      case FacebookLoginStatus.cancelledByUser:
//        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
//        setState(() => _isLoggedIn = false);
        break;
    }
  }
}
