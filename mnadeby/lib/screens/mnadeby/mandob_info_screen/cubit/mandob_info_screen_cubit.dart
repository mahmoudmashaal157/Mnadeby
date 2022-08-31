import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/shared/components/data.dart';
import 'package:mnadeby/shared/components/toast/toast.dart';

part 'mandob_info_screen_state.dart';

class MandobInfoScreenCubit extends Cubit<MandobInfoScreenState> {
  MandobInfoScreenCubit() : super(MandobInfoScreenInitial());
  
  static MandobInfoScreenCubit get(BuildContext context) => BlocProvider.of(context);
  
  void deleteMandob({required String uId, required String mandobName}){
    emit(DeleteMandobLoadingState());
    FirebaseFirestore.instance.collection("mnadeb-info").doc(uId).delete().then((value) {
      mnadebNames.remove(mandobName);
      emit(DeleteMandobSuccessfullyState());
      Fluttertoast.showToast(
          msg: "تم مسح المندوب بنجاح قم بنقل اوردرات هذا المندوب الى مندوب اخر",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,
          fontSize: 16,
          textColor: Colors.white
      );
    }).catchError((error){
      emit(DeleteMandobErrorState());
      print(error.toString());
    });
  }
  
}
