import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/mnadebMoneyModel.dart';

part 'money_screen_state.dart';

class MoneyScreenCubit extends Cubit<MoneyScreenState> {
  MoneyScreenCubit() : super(MoneyScreenInitial());

  static MoneyScreenCubit get(BuildContext context)=>BlocProvider.of(context);

  double total=0;
  Map<String,double>_mnadebMoney={};
  List<MnadebMoneyModel>mnadebMoneyList=[];
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

  void collectMoneyFromMnadeb(){
    emit(CollectMnadebMoneyLoadingState());
    total=0;
    _mnadebMoney={};
    mnadebMoneyList=[];
    FirebaseFirestore.instance.collection("orders").doc(date).collection("order-info").where("status" ,isEqualTo: "تم التوصيل").get().then((value) {
      value.docs.forEach((element) {
       if(_mnadebMoney[element.data()['mandobName']]==null){
         _mnadebMoney[element.data()['mandobName']] = element.data()['deliveryPrice'];
         total+=element.data()['deliveryPrice'];
       }
       else {
         double? mandobMoney = _mnadebMoney[element.data()['mandobName']];
         mandobMoney = mandobMoney! + element.data()['deliveryPrice'];
         _mnadebMoney[element.data()['mandobName']] = mandobMoney;
         total+=element.data()['deliveryPrice'];
       }
      });
      _mnadebMoney.forEach((key, value) {
        mnadebMoneyList.add(MnadebMoneyModel(name: key, money: value));
      });
      print(total);
      emit(CollectMnadebMoneySuccessfullyState());
    }).catchError((error){
      emit(CollectMnadebMoneyErrorState());
      print(error.toString());
    });
  }

}
