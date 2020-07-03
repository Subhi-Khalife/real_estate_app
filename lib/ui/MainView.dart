import 'package:flutter/material.dart';
import 'package:projects/ui/explore/explore.dart';
import 'package:projects/ui/favourite/favorite.dart';
import 'package:projects/ui/notification.dart';
import 'package:projects/ui/profile.dart';
import 'package:projects/widget/bottom_navigation_bar.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int currentIndex = 0 ;

  onTap(int index)
  {
    setState(() {
      currentIndex =index;
    });
  }

   final tabs =[
    ExploreView(),
    FavoriteView(),
    NotificationsView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavBar(
        iconProfile: Icons.person,
        iconFavorite: Icons.favorite,
        iconAlert: Icons.notifications,
        iconExplore: Icons.search,
        textProfile: "Profile",
        textFavorite:"Favorite",
        textExplore: "Explore",
        textAlert: "Alert",
        onTap: onTap,
        index: currentIndex,
      ),
    );
  }
}
