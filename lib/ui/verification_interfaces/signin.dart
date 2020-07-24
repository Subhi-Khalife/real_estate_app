import 'package:flutter/cupertino.dart';
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
  TextEditingController _emailController , _passwordController ,_passwordConfirmController,_firstNameController,_lastNameController,_phoneNumberController,_birthdayController,_cityController ;
  bool isLockPassword = false;
  bool isCheck =false;
  FocusNode _passwordFocus =FocusNode() , _passwordConfirmFocus =FocusNode() ,
      _firstNameFocus =FocusNode() ,  _lastNameFocus =FocusNode() ,
      _phoneNumberFocus =FocusNode(), _emailFocus =FocusNode();
  Color colorIconPass = colorGrey ;
  Color colorIconPassConfirm = colorGrey ;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController =TextEditingController();
    _passwordConfirmController =TextEditingController();
    _firstNameController =TextEditingController();
    _lastNameController =TextEditingController();
    _phoneNumberController =TextEditingController();
    _birthdayController =TextEditingController();
    _cityController =TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    print("hei $height");
    return Scaffold(
      backgroundColor: backgroundColorScaffold,
      body: Padding(
        padding:  EdgeInsets.only(left: 20,right: 20,bottom: 15),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Center(
              child: LogInTitle(
                title: "SignUp",
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 20,),
                  Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShowImage("svg/Login-rafiki.svg",height: height * 0.5,boxFit: BoxFit.fitHeight,),
                              SizedBox(height: height*0.05,),
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
                                    controller: _firstNameController,
                                    isTextFieldPassword: false,
                                    focusNode: _firstNameFocus,
                                    labelText: "First Name",
                                    onSubmitted: (val){
                                      FocusScope.of(context).requestFocus(_lastNameFocus);
                                    },
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Flexible(
                                  flex: 1,
                                  child: TextFieldApp(
                                    controller: _lastNameController,
                                    isTextFieldPassword: false,
                                    labelText: "Last Name",
                                    focusNode: _lastNameFocus,
                                    onSubmitted: (val){
                                      FocusScope.of(context).requestFocus(_phoneNumberFocus);
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
                              labelText: "Phone Number",
                              keyboardType: TextInputType.phone,
                              onSubmitted: (val){
                                FocusScope.of(context).requestFocus(_emailFocus);
                              },
                            ),
                            SizedBox(height: 15),
                            TextFieldApp(
                              controller: _emailController,
                              isTextFieldPassword: false,
                              labelText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _emailFocus,
                              onSubmitted: (val){
                                FocusScope.of(context).requestFocus(_passwordFocus);
                              },
                            ),
                            SizedBox(height: 15),
                            InkWell(
                              onTap: (){
                                if(_birthdayController.text.trim() == "")
                                  _birthdayController.text = parseToDateTime(DateTime.now());
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),topLeft: Radius.circular(15.0))),
                                      builder: (context){
                                    return Container(
                                      height: MediaQuery.of(context).size.height *0.6,
                                      margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                      child: ListView(
                                        children: [
                                          SizedBox(height: 10,),
                                          Text("Select Date",textAlign: TextAlign.center,style: TextStyle(
                                            fontSize: 18,color: Colors.black54
                                          ),),
                                          SizedBox(height: 10,),
                                          Container(
                                            height:MediaQuery.of(context).size.height *0.4,
                                            child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode.date,
                                                initialDateTime: DateTime.now(),
                                                onDateTimeChanged: (dateTime){
                                                  print("date Time $dateTime}");
                                                  _birthdayController.text = parseToDateTime(dateTime);
                                                }),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: 20,right: 20.0),
                                            child: ButtonApp(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              textButton: "Apply",

                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              child: TextFieldApp(
                                controller: _birthdayController,
                                isTextFieldPassword: false,
                                labelText: "Birthday",
                                isEnable: false,
                                onSubmitted: (val){
                                  FocusScope.of(context).requestFocus(_passwordFocus);
                                },icon: Icons.date_range,
                              ),
                            ),
                            SizedBox(height:15,),
                            TextFieldApp(
                              controller: _cityController,
                              isTextFieldPassword: false,
                              labelText: "City",
                              onSubmitted: (val){
                                FocusScope.of(context).requestFocus(_passwordFocus);
                              },
                              icon: Icons.arrow_drop_down,
                              isEnable: false,
                            ),
                            SizedBox(height:15,),
                            TextFieldApp(
                              controller: _passwordController,
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
                              controller: _passwordConfirmController,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ButtonApp(
                                onPressed: (){},
                                textButton: "SignUp",
                                colorButton: Colors.indigo.shade900,
                                heightButton: 50,
                              ),
                            ),
                            SizedBox(height:15,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ButtonApp(
                                onPressed: (){},
                                textButton: "SignUp with Facebook",
                                colorButton: activeIconNavBar,
                                heightButton: 50,
                              ),
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
  
  String parseToDateTime(DateTime time){
    return "${time.year}/${time.month}/${time.day}";
  }
}
