import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/bloc/add_properety_dart_bloc.dart';
import 'package:real_estate_app/bloc/bloc_get_all_country/country_bloc.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/ui/add_properity/provier_property.dart';
import 'package:real_estate_app/ui/explore/filter_provider.dart';
import 'package:real_estate_app/ui/splash_screen.dart';

void main() {
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
          create: (context) => ExploreDartBloc()..add(LoadingExploreData()),
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
      title: "Dalal ",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

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
