import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mnadeby/screens/layout_screen/LayoutScreen.dart';
import 'package:mnadeby/screens/mnadeby/add_mandob/AddMandobScreen.dart';
import 'package:mnadeby/screens/mnadeby/mandob_info_screen/MandobInfoScreen.dart';
import 'package:mnadeby/screens/mnadeby/mandob_orders_screen/mandobOrdersScreen.dart';
import 'package:mnadeby/screens/mnadeby/mandob_tracking_screen/MandobTrackingScreen.dart';
import 'package:mnadeby/screens/on_boarding/OnBoardingScreen.dart';
import 'package:mnadeby/shared/bloc_observer/bloc_observer.dart';
import 'package:mnadeby/shared/cache_helper/cache_helper.dart';
import 'package:mnadeby/shared/components/data.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.sharedPrefenceInstance();
  getNewOrderNumber();

  BlocOverrides.runZoned(
        () async {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
   late bool onBoardingcheck = checkOnBoardingVisited();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(Color(0xff34a853)),
        appBarTheme: AppBarTheme(
          color: Color(0xff34a853)
        )
        //34a853
      ),
      home: onBoardingcheck == false ? OnBoardingScreen() : LayoutScreen(),
    );
  }

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
  bool checkOnBoardingVisited(){
    if(CacheHelper.getData(key: "boarding_visited")==null){
      return false;
    }
    else {
      return true;
    }
  }
}

void getNewOrderNumber(){
  if(CacheHelper.getData(key: "newOrderNumber")==null){
    newOrderNumber = 0;
    CacheHelper.setData(key: 'newOrderNumber', value: 0);
  }
  else{
    newOrderNumber = CacheHelper.getData(key: 'newOrderNumber');
  }
}






