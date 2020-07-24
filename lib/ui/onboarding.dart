import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/widget/page_model.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  ValueNotifier<int> _pageIndexNotifier = ValueNotifier(0);

  List<PageModel> pages;

  void _addPages() {
    pages = List<PageModel>();

    pages.add(PageModel("Search For you the perfect property",
        "which suit your jop", "svg/navigation_amico.svg"));
    pages.add(PageModel(
        "Explore Apartments Near You",
        "finding an apartment has never been easies until now",
        "svg/kids_studying_from_home_amico.svg"));
    pages.add(PageModel(
        "Explore Apartments Near You",
        "finding an apartment has never been easies until now",
        "svg/house_searching_rafiki.svg"));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 34, left: 34, top: 70, bottom: 56),
                    child: SvgPicture.asset(
                      pages[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Text(
                      pages[index].title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
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
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonLogIn(index),
                        ButtonSignUp(index),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
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
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: _Page_View_Indicator(pages.length),
            ))
      ],
    );
  }

  Widget ButtonLogIn(int index) {
    if (index == pages.length - 1) {
      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
              color: Colors.blue.shade900,
              child: Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {}),
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
        width: MediaQuery.of(context).size.width / 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "SIGN UP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 1),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {}),
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
      normalBuilder: (animationController, index) => Circle(
        size: 10.0,
        color: Colors.white,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 16.0,
          color: Colors.blue.shade900,
        ),
      ),
    );
  }
}
