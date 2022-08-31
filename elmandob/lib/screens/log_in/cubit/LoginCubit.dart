import 'package:elmandob/screens/log_in/cubit/LoginState.dart';
import 'package:elmandob/shared/cache_helper/cache_helper.dart';
import 'package:elmandob/shared/components/data.dart';
import 'package:elmandob/shared/components/toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super (LoginInitialState());

  static LoginCubit get(BuildContext context) =>BlocProvider.of(context);
  bool passwordVisiblity = true;

  void changePasswordVisiblity(){
    passwordVisiblity = !passwordVisiblity;
    emit(ChangePasswordVisiblityState());
  }

  void mandobLogin({required String email, required String password}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      uId = value.user!.uid;
      CacheHelper.setData(key: "uId", value: value.user!.uid);
      emit(LoginSuccessfullyState());
    }).catchError((error){
      showToast(msg: "خطأ في االايميل او الباسورد", backgroundColor: Colors.red, textColor: Colors.white);
      emit(LoginErrorState());
      print(error.toString());
    });
  }


}