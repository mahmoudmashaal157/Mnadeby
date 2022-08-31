import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/models/MandobInfoModel.dart';
import 'package:mnadeby/shared/components/data.dart';
import 'package:mnadeby/shared/components/toast/toast.dart';

part 'add_mandob_screen_state.dart';

class AddMandobScreenCubit extends Cubit<AddMandobScreenState> {
  AddMandobScreenCubit() : super(AddMnadobScreenInitial());

  static AddMandobScreenCubit get(BuildContext context) =>
      BlocProvider.of(context);

  bool passwordVisiblity = true;
  File? image;
  var picker = ImagePicker();
  double progressPercent=0.0;
  int progressFlag=0;

  void changePasswordVisiblity() {
    passwordVisiblity = !passwordVisiblity;
    emit(ChangePasswordVisiblityState());
  }

  Future<void> selectImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(PickImageFromGallerySuccessfullyState());
    } else {
      print("no Image Selected");
    }
  }

  void addMandob({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    if(mnadebNames.contains(name)){
      showToast(msg: "عفوا اسم المندوب موجود بالفعل قم بتغير اسم المندوب", backgroundColor: Colors.red, textColor: Colors.white);
    }
    else {
      progressFlag=1;
      emit(CreateUserLoadingState());
      String? imageUrl;
      String? uId;
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        uId = value.user!.uid;
        progressPercent=25;
        emit(CreateUserEmailAndPasswordSuccessfullyState());
        FirebaseStorage.instance.ref().child("mnadebyPhotos/${Uri.file(image!.path).pathSegments.last}").putFile(image!).then((value) {
          progressPercent = 50;
          emit(UploadMandobImageSuccessfullyState());
          value.ref.getDownloadURL().then((value) {
            progressPercent=75;
            imageUrl = value;
            emit(DownloadMandobImageURLSuccessfullyState());
            MandobInfoModel mandob = MandobInfoModel(
                name: name,
                phone: phone,
                password: password,
                email: email,
                uId: uId,
                image: imageUrl
            );
            FirebaseFirestore.instance
                .collection("mnadeb-info")
                .doc(uId)
                .set(mandob.toMap())
                .then((value) {
              progressPercent=100;
              progressFlag=0;
              emit(AddMandobInfoSuccessfullyState());
              showToast(msg: "تم اضافة المندوب بنجاح", backgroundColor: Colors.green, textColor: Colors.white);
            });
          });
        });
      }).catchError((error){
        print(error.toString());
      });
    }

  }
}
