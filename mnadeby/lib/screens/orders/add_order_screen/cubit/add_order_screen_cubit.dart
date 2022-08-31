import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/OrderModel.dart';
import 'package:mnadeby/shared/cache_helper/cache_helper.dart';
import 'package:mnadeby/shared/components/data.dart';
import 'package:mnadeby/shared/components/toast/toast.dart';

part 'add_order_screen_state.dart';

class AddOrderScreenCubit extends Cubit<AddOrderScreenState> {
  AddOrderScreenCubit() : super(AddOrderScreenInitial());

  static AddOrderScreenCubit get(BuildContext context) =>
      BlocProvider.of(context);

  late String mandobName = mnadebNames[0];

  void changeMandobName(String value) {
    mandobName = value;
    emit(ChangeNameOfMandobState());
  }

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

  void addNewOrder({
    required String orderAddress,
    required String orderOwnerName,
    required String orderOwnerNumber,
    required String orderNewOwnerName,
    required String orderNewOwnerNumber,
    required String mandobName,
    required double deliveryPrice,
    required String location,
  }) {
    emit(AddNewOrderLoadingState());
    newOrderNumber++;
    CacheHelper.setData(key: "newOrderNumber", value: newOrderNumber);
    OrderModel newOrder = OrderModel(
        orderNumber: newOrderNumber,
        orderAddress: orderAddress,
        orderOwnerName: orderOwnerName,
        orderOwnerNumber: orderOwnerNumber,
        orderNewOwnerName: orderNewOwnerName,
        orderNewOwnerNumber: orderNewOwnerNumber,
        mandobName: mandobName,
        deliveryPrice: deliveryPrice,
        location: location,
      date: date,
      mandobId: mnadebNamesAndIdMap[mandobName]
    );
    FirebaseFirestore.instance.collection('orders').doc(date).collection("order-info").doc(newOrderNumber.toString()).set(newOrder.toMap()).then((value) {
          emit(AddNewOrderSuccessfullyState());
          showToast(msg: "تم اضافة الاوردر بنجاح", backgroundColor: Colors.green, textColor: Colors.white);
    }).catchError((error){
      print(error.toString());
      emit(AddNewOrderErrorState());
    });
  }
}
