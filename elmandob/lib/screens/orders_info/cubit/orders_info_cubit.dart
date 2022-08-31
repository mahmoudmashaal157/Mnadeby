import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmandob/shared/components/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'orders_info_state.dart';

class OrdersInfoCubit extends Cubit<OrdersInfoState> {
  OrdersInfoCubit() : super(OrdersInfoInitial());
  
  static OrdersInfoCubit get (BuildContext context)=>BlocProvider.of(context);

  String? date;

  void getDateNow(){
    date = _changeDateFormat(DateTime.now());
  }

  String _changeDateFormat(DateTime unFormattedDate){
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(unFormattedDate).toString();
  }
  
  void updateStatusOfTheOrder({required String status, required String orderNumber}){
    getDateNow();
    emit(UpdateOrderStatusLoadingState());
    FirebaseFirestore.instance.collection("orders").doc(date).collection("order-info").doc(orderNumber).update({
      "status":status
    }).then((value) {
      showToast(msg: "$status", backgroundColor: Colors.green, textColor: Colors.white);
      emit(UpdateOrderStatusSuccessfullyState());
    }).catchError((error){
      emit(UpdateOrderStatusErrorState());
      print(error.toString());
    });
  }
}
