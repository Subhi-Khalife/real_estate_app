import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/explore/explore.dart';
import 'package:real_estate_app/ui/favourite/favorite.dart';
import 'package:real_estate_app/ui/notification.dart';
import 'package:real_estate_app/ui/profile.dart';
import 'package:real_estate_app/widget/bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int currentIndex = 3 ;

  onTap(int index)
  {
    setState(() {
      currentIndex =index;
    });
  }

   final tabs =[
     ProfileView(),
     NotificationsView(),
     FavoriteView(),
     ExploreView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavBar(
        iconProfile:currentIndex == 0 ? CupertinoIcons.person_solid : CupertinoIcons.person,
        iconFavorite:currentIndex == 2 ? CupertinoIcons.heart_solid: CupertinoIcons.heart,
        iconAlert: currentIndex == 1 ?CupertinoIcons.news_solid :CupertinoIcons.news,
        iconExplore:CupertinoIcons.search,
        textProfile: "الملف الشخصي",
        textFavorite:"المفضلة",
        textExplore: "استكشاف",
        textAlert: "الأخبار",
        onTap: onTap,
        index: currentIndex,
      ),
    );
  }
}
