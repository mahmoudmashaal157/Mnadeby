import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmandob/models/OrderModel.dart';
import 'package:elmandob/shared/components/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  static OrdersCubit get(BuildContext context) =>BlocProvider.of(context);

  String? date;
  List<OrderModel>mandobOrders=[];
  void getDateNow(){
    date = _changeDateFormat(DateTime.now());
  }
  
  String _changeDateFormat(DateTime unFormattedDate){
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(unFormattedDate).toString();
  }

  Future<void> getMandobOrders()async {
    mandobOrders=[];
    emit(GetMandobOrdersLoadingState());
    FirebaseFirestore.instance.collection("orders").doc(date).collection("order-info").where("mandobId", isEqualTo: uId).get().then((value) {
      value.docs.forEach((element) {
        mandobOrders.add(OrderModel.fromJson(element.data()));
      });
      emit(GetMandobOrdersSuccessfullyState());
    }).catchError((error){
      emit(GetMandobOrdersErrorState());
      print(error.toString());
    });
  }

  Future<void> setMandobLocation()async {
    bool serviceEnabled;
    LocationPermission permission;
    print("here");

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((event) {
      print(event.longitude);
      print(event.latitude);
      FirebaseFirestore.instance.collection("mnadeb-info").doc(uId).update(
          {
            "longitude":event.longitude,
            "latitude":event.latitude
          });
    });

  }

}
