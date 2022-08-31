import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'mandob_tracking_state.dart';

class MandobTrackingBloc extends Cubit<MandobTrackingState> {

  static MandobTrackingBloc get(BuildContext context)=>BlocProvider.of(context);
  double longitude=0;
  double latitude=0;

  MandobTrackingBloc() : super(MandobTrackingInitial());

  void getMandobLocation({required String uId}){
    emit(GetMandobTrackingLoadingState());
     FirebaseFirestore.instance.collection("mnadeb-info").doc(uId).snapshots().listen((event) {
      longitude = event.data()!['longitude'];
      latitude = event.data()!['latitude'];
      emit(GetMandobTrackingSuccessfullyState());
    });
  }
}
