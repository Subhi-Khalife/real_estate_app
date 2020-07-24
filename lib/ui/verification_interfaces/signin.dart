import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/verification_interfaces/login.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController _emailController , _passwordController ,_passwordConfirmController ;
  bool isLockPassword = false;
  bool isCheck =false;
  FocusNode _passwordFocus =FocusNode() , _passwordConfirmFocus =FocusNode() ;
  Color colorIconPass = colorGrey ;
  Color colorIconPassConfirm = colorGrey ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController =TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    print("hei $height");
    return Scaffold(
      backgroundColor: backgroundColorScaffold,
      body: Padding(
        padding:  EdgeInsets.only(left: 20,right: 20,bottom: 15),
        child: ListView(
          children: <Widget>[
            SizedBox(height: height*0.1,),
            ShowImage("svg/Login-rafiki.svg",height: height * 0.27,boxFit: BoxFit.fitHeight,),
            SizedBox(height: height*0.05,),
            Center(
              child: LogInTitle(
                title: "SignUp",
              ),
            ),
            SizedBox(height: 15),
            TextFieldApp(
              controller: _emailController,
              isTextFieldPassword: false,
              labelText: "Email",
              onSubmitted: (val){
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
            SizedBox(height:15,),
            TextFieldApp(
              controller: _passwordConfirmController,
              isTextFieldPassword: true,
              focusNode: _passwordFocus,
              labelText: "Password",
              colorIcon: colorIconPass,
              onChange: (val){
                if(val.toString().trim() != "")
                  setState(() {
                    colorIconPass = activeIconNavBar;
                  });
                else
                  setState(() {
                    colorIconPass = colorGrey;
                  });
              },
              onSubmitted: (val){
                FocusScope.of(context).requestFocus(_passwordConfirmFocus);
              },
              isLookAtPassword: isLockPassword,
              onPressedLookAtPassword: (){
                setState(() {
                  isLockPassword =!isLockPassword;
                });
              },

            ),
            SizedBox(height:15,),
            TextFieldApp(
              controller: _passwordController,
              isTextFieldPassword: true,
              focusNode: _passwordConfirmFocus,
              labelText: "Confirm Password",
              colorIcon: colorIconPassConfirm,
              onChange: (val){
                if(val.toString().trim() != "")
                  setState(() {
                    colorIconPassConfirm = activeIconNavBar;
                  });
                else
                  setState(() {
                    colorIconPassConfirm = colorGrey;
                  });
              },
              onSubmitted: (val){
                FocusScope.of(context).unfocus();
              },
              isLookAtPassword: isLockPassword,
              onPressedLookAtPassword: (){
                setState(() {
                  isLockPassword =!isLockPassword;
                });
              },

            ),
            SizedBox(height:15,),
            ButtonApp(
              onPressed: (){},
              textButton: "SignUp",
              colorButton: Colors.indigo.shade900,
              heightButton: 50,
            ),
            SizedBox(height:15,),
            ButtonApp(
              onPressed: (){},
              textButton: "SignUp with Facebook",
              colorButton: activeIconNavBar,
              heightButton: 50,
            ),
            SizedBox(height:30,),
            Center(
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => LoginView()
                      ), (route) => false);
                    },
                    child: Text("Already Have an account ?",style: TextStyle(color: Colors.indigo.shade900.withOpacity(0.7)),))),
          ],
        ),
      ),
    );
  }
}
