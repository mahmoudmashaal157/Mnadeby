import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/MandobInfoModel.dart';
import 'package:mnadeby/shared/cache_helper/cache_helper.dart';
import 'package:mnadeby/shared/components/data.dart';

part 'mnadeby_screen_state.dart';

class MnadebyScreenCubit extends Cubit<MnadebyScreenState> {
  MnadebyScreenCubit() : super(MnadebyScreenInitial());

  static MnadebyScreenCubit get(BuildContext context)=>BlocProvider.of(context);

  List<MandobInfoModel>mnadeby=[];


  void getMnadeby(){
    mnadeby=[];
    mnadebNames=[];
    mnadebNamesAndIdMap={};
    emit(GetMnadebyLoadingState());

    FirebaseFirestore.instance.collection("mnadeb-info").get().then((value) {
      value.docs.forEach((element) {
        mnadebNames.add(element.data()['name']);
        mnadebNamesAndIdMap[element.data()['name']] = element.data()['uId'];
        mnadeby.add(MandobInfoModel.fromJson(element.data()));
      });
      print(mnadebNames.length);
      emit(GetMnadebySuccessfullyState());
    }).catchError((error){
      emit(GetMnadebyErrorState());
      print(error.toString());
    });
  }
}
