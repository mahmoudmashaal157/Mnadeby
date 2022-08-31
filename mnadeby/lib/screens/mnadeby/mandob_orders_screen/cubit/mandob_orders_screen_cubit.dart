import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/OrderModel.dart';
import 'package:mnadeby/shared/components/data.dart';

part 'mandob_orders_screen_state.dart';

class MandobOrdersScreenCubit extends Cubit<MandobOrdersScreenState> {
  MandobOrdersScreenCubit() : super(MandobOrdersScreenInitial());

  static MandobOrdersScreenCubit get(BuildContext context)=>BlocProvider.of(context);

  List<OrderModel>mandobOrdersList=[];

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

  void getMandobOrders({required String mandobName}){
    mandobOrdersList=[];
    emit(GetMandobOrdersLoadingState());
    FirebaseFirestore.instance.collection("orders").doc(date).collection("order-info").where('mandobId',isEqualTo: mnadebNamesAndIdMap[mandobName]).get().then((value) {
      value.docs.forEach((element) {
        mandobOrdersList.add(OrderModel.fromJson(element.data()));
      });
      emit(GetMandobOrdersSuccessfullyState());
    }).catchError((error){
      emit(GetMandobOrdersErrorState());
      print(error.toString());
    });

  }

}
