import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/OrderModel.dart';
import 'package:mnadeby/shared/components/data.dart';
import 'package:mnadeby/shared/components/toast/toast.dart';

part 'order_details_screen_state.dart';

class OrderDetailsScreenCubit extends Cubit<OrderDetailsScreenState> {
  OrderDetailsScreenCubit() : super(OrderDetailsScreenInitial());

  static OrderDetailsScreenCubit get(BuildContext context) =>
      BlocProvider.of(context);

  String? mandobName;

  void changeMandobName(String value) {
    mandobName = value;
    emit(ChangeNameOfMandobState());
  }

  String? date;

  void changeDate(DateTime newDate) {
    date = _changeDateFormat(newDate);
    emit(ChangeDateState());
  }

  void changeDateState() {
    emit(ChangeDateState());
  }

  String _changeDateFormat(DateTime unFormattedDate) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(unFormattedDate).toString();
  }

  void checkMandobName({required String mandobName}){
    if(mnadebNames.contains(mandobName)){
      this.mandobName = mandobName;
    }
  }


  void updateOrderInfo({
    required int orderNumber,
    required String orderAddress,
    required String orderOwnerName,
    required String orderOwnerNumber,
    required String orderNewOwnerName,
    required String orderNewOwnerNumber,
    required String mandobName,
    required double deliveryPrice,
    String? location,
    required String newDate,
    required String oldDate
  }) {
    emit(UpdateOrderInfoLoadingState());

    OrderModel orderInfo = OrderModel(orderNumber: orderNumber,
        orderAddress: orderAddress,
        orderOwnerName: orderOwnerName,
        orderOwnerNumber: orderOwnerNumber,
        orderNewOwnerName: orderNewOwnerName,
        orderNewOwnerNumber: orderNewOwnerNumber,
        mandobName: mandobName,
        deliveryPrice: deliveryPrice,
        date: newDate,
      location: location,
      mandobId: mnadebNamesAndIdMap[mandobName]
    );

    if (newDate != oldDate) {
      FirebaseFirestore.instance.collection('orders').doc(oldDate).collection(
          'order-info').doc(orderNumber.toString()).delete().then((value) {
        FirebaseFirestore.instance.collection('orders').doc(newDate).collection(
            'order-info').doc(orderNumber.toString()).set(orderInfo.toMap()).then((value) {
              emit(UpdateOrderInfoSuccessfullyState());
              showToast(msg: "تم التعديل بنجاح", backgroundColor: Colors.green, textColor: Colors.white);
        });
      }).catchError((error) {
        print(error.toString());
        emit(UpdateOrderInfoErrorState());
      });
    }
    else {
      FirebaseFirestore.instance.collection('orders').doc(newDate).collection(
          'order-info').doc(orderNumber.toString()).update(orderInfo.toMap()).then((value) {
        emit(UpdateOrderInfoSuccessfullyState());
        showToast(msg: "تم التعديل بنجاح", backgroundColor: Colors.green, textColor: Colors.white);
      }).catchError((error){
        emit(UpdateOrderInfoErrorState());
        print(error.toString());
      });
    }
  }

}
