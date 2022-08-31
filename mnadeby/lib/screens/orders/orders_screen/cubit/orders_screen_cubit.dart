import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/OrderModel.dart';

part 'orders_screen_state.dart';

class OrdersScreenCubit extends Cubit<OrdersScreenState> {
  OrdersScreenCubit() : super(OrdersScreenInitial());

  static OrdersScreenCubit get(BuildContext context) =>
      BlocProvider.of(context);
  List<OrderModel>ordersList=[];

  String? date;
  void getDateNow(){
    date = _changeDateFormat(DateTime.now());
  }

  void changeDate(DateTime newDate){
    date = _changeDateFormat(newDate);
    emit(ChangeDateState());
  }
  String _changeDateFormat(DateTime unFormattedDate){
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(unFormattedDate).toString();
  }

  Future <void> getAllOrders()async {
    ordersList=[];
    emit(GetAllOrdersLoadingState());
    FirebaseFirestore.instance.collection("orders").doc(date).collection("order-info").get().then((value) {
      value.docs.forEach((element) {
        ordersList.add(OrderModel.fromJson(element.data()));
      });
      emit(GetAllOrdersSuccessfullyState());
    }).catchError((error){
      emit(GetAllOrdersErrorState());
      print(error.toString());
    });
  }
  
  void deleteOrder({required String date, required String orderNumber}){
    emit(DeleteOrderLoadingState());
    FirebaseFirestore.instance.collection("orders").doc(date).collection("order-info").doc(orderNumber).delete().then((value) {
      getAllOrders();
      emit(DeleteOrderSuccessfullyState());
    }).catchError((error){
      emit(DeleteOrderErrorState());
      print(error.toString());
    });
    
  }

}
