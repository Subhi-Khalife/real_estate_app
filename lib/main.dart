import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/filter_provider.dart';
import 'package:real_estate_app/Provider/google_map_provider.dart';
import 'package:real_estate_app/Provider/house_category_provider.dart';
import 'package:real_estate_app/Provider/provier_property.dart';
import 'package:real_estate_app/bloc/bloc_get_all_country/country_bloc.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/bloc/favourits/favourits_bloc.dart';
import 'package:real_estate_app/bloc/news_bloc/news_bloc.dart';
import 'package:real_estate_app/bloc/profile/profile_bloc.dart';
import 'package:real_estate_app/ui/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/add_properity/add_properety_dart_bloc.dart';

Future<void> main() {
  // SharedPreferences.setMockInitialValues({});
  runApp(
    MultiBlocProvider(
      providers: [//ExploreDartBloc
        BlocProvider<AddProperetyDartBloc>(
          create: (context) => AddProperetyDartBloc()..add(LoadingData()),
        ),
        BlocProvider<CountryBloc>(
          create: (context) => CountryBloc()..add(GetAllCountry()),
        ),
        BlocProvider<ExploreDartBloc>(
          create: (context) => ExploreDartBloc()..add(LoadingExploreData(context)),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc()..add(GetProfileUserEvent()),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc()..add(GetAllNewsEvent()),
        ),
        BlocProvider<FavouritsBloc>(
          create: (context) => FavouritsBloc()..add(GetAllFavouritEvent()),
        ),
      ],
      child: MultiProvider(
        providers: [//propertyProvider
          ChangeNotifierProvider(
            create: (BuildContext context) => FilterProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => PropertyProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => GoogleMapProvider(),
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) => HousesCategoryProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "تطبيق دلال ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashScreen());
  }
}
