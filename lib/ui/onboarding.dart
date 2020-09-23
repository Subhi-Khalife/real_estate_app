import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/ui/verification_interfaces/login.dart';
import 'package:real_estate_app/ui/verification_interfaces/signup.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/page_model.dart';
import 'package:real_estate_app/widget/shared_preference.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  ValueNotifier<int> _pageIndexNotifier = ValueNotifier(0);

  List<PageModel> pages;
  PageController _pageController = PageController(initialPage: 0);

  void _addPages() {
    pages = List<PageModel>();

    pages.add(PageModel("ابحث عن العقار المثالي لك",
        "الذي يناسب وظيفتك", "svg/navigation_amico.svg"));
    pages.add(PageModel(
        "استكشف الشقق القريبة منك",
        "لم يكن العثور على شقة سهلاً حتى الآن؟",
        "svg/kids_studying_from_home_amico.svg"));
    pages.add(PageModel(
        "فلترة نتائج البحث ",
        "إظهار النتائج على الخريطة و عرضها في قسم التصنيفات",
        "svg/house_searching_rafiki.svg"));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: SvgPicture.asset(
                        pages[index].image,
                        fit: BoxFit.fitWidth,
                        height: MediaQuery.of(context).size.height*0.3,
                      ),
                    ),
                    Spacer(flex: 1,),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: Text(
                        pages[index].title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 48, right: 48, top: 24),
                      child: Text(
                        pages[index].message,
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    index == 2 ?Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonLogIn(index),
                          ButtonSignUp(index),
                        ],
                      ),
                    ) :Container(),
                    Spacer(flex: 1,)
                  ],
                );
              },
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  _pageIndexNotifier.value = index;
                });
              },
            ),
          ),
          Visibility(
            visible: _pageIndexNotifier.value == 0,
            child: Positioned.fill(
                top: 40,
                right: 10,
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Skip",
                          style: TextStyle(color: colorApp, fontSize: 20),
                        ),
                        ShowUp(
                          child: Row(
                            children: <Widget>[
                              Transform.translate(
                                offset: Offset(0, 2),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: colorApp,
                                  size: 15,
                                ),
                              ),
                              Transform.translate(
                                  offset: Offset(-10, 2),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: colorApp,
                                    size: 15,
                                  )),
                            ],
                          ),
                          delay: 1500,
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          Positioned.fill(
              bottom: 15,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _Page_View_Indicator(pages.length)))
        ],
      ),
    );
  }

  Widget ButtonLogIn(int index) {
    if (index == pages.length - 1) {
      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
              color: colorApp,
              child: Text(
                "تسجيل الدخول",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () async {
                await SharedPreferenceStore.setShowOnBoarding("LogInPressed");
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginView()),
                    (Route ee) => false);
              }),
        ),
      );
    } else
      return Container(
        height: 0,
        width: 0,
      );
  }

  Widget ButtonSignUp(int index) {
    if (index == pages.length - 1) {
      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
              color: activeIconNavBar,
              child: Text(
                "إنشاء حساب",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () async{
                await SharedPreferenceStore.setShowOnBoarding("SignUpPressed");
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => SignInView()),
                    (Route ee) => false);
              }),
        ),
      );
    } else
      return Container(
        height: 0,
        width: 0,
      );
  }

  Widget _Page_View_Indicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: colorApp, width: 2),
            borderRadius: BorderRadius.circular(45.0)),
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.bounceInOut,
        ),
        child: Circle(
          size: 18.0,
          color: colorApp,
        ),
      ),
    );
  }
}

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ShowUp({@required this.child, this.delay});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(-0.2, 0.0), end: Offset(0.1, 0.0))
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
