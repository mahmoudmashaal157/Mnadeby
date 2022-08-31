import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmandob/screens/log_in/LoginScreen.dart';
import 'package:elmandob/screens/orders/OrdersScreen.dart';
import 'package:elmandob/shared/bloc_observer/bloc_observer.dart';
import 'package:elmandob/shared/cache_helper/cache_helper.dart';
import 'package:elmandob/shared/components/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.sharedPrefenceInstance();
  uId = CacheHelper.getData(key: "uId");
  await setMandobPermissions();
  setMandobLocationWhenOn();

  BlocOverrides.runZoned(
    () async {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: buildMaterialColor(Color(0xff34a853)),
          appBarTheme: AppBarTheme(color: Color(0xff34a853))
          //34a853
          ),
      home: CacheHelper.getData(key: "uId") == null
          ? LoginScreen()
          : OrdersScreen(),
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
}

Future<void> setMandobPermissions()async {
  Location location = new Location();

  bool _serviceEnabled;
  location.enableBackgroundMode(enable: true);

  _serviceEnabled = await location.serviceEnabled();
   await location.requestPermission();

}

  void setMandobLocationWhenOn(){
    Location().onLocationChanged.listen((event) {
      print(event.longitude);
      insertLocationToFirebase(event.longitude!, event.latitude!);
    });
}

void insertLocationToFirebase(double longitude, double latitude){
  FirebaseFirestore.instance.collection("mnadeb-info").doc(uId).update({
    "longitude":longitude,
    "latitude":latitude
  });
}
