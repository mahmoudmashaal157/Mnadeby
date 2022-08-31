
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mnadeby/shared/components/toast/toast.dart';

part 'edit_mandob_info_state.dart';

class EditMandobInfoCubit extends Cubit<EditMandobInfoState> {
  EditMandobInfoCubit() : super(EditMandobInfoInitial());

  static EditMandobInfoCubit get(BuildContext context)=>BlocProvider.of(context);

  File? image;
  var picker = ImagePicker();
  double percentProgres=0;
  int progressFlag=0;

  Future<void> selectImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(PickImageFromGallerySuccessfullyState());
    } else {
      print("no Image Selected");
    }
  }

  void _editMandobInfoWithoutImage({required String phone, required String name, required String uId}){
    progressFlag=1;
    percentProgres=75;
    emit(UpdateMandobInfoLoadingState());
    FirebaseFirestore.instance.collection("mnadeb-info").doc(uId).update({
      "name":name,
      "phone":phone
    }).then((value) {
      percentProgres=100;
      progressFlag=0;
      showToast(msg: "تم تعديل بيانات المندوب بنجاح", backgroundColor: Colors.green, textColor: Colors.white);
      emit(UpdateMandobInfoSuccessfullyState());
      percentProgres=0;
    }).catchError((error){
      emit(UpdateMandobInfoErrorState());
      print(error.toString());
    });
  }

  void _editMandobInfoWithImage({required String phone, required String name, required String uId}){
    String? imageURL;
    progressFlag=1;
    emit(UpdateMandobInfoLoadingState());
    FirebaseStorage.instance.ref().child("mnadebyPhotos/${Uri.file(image!.path).pathSegments.last}").putFile(image!).then((value) {
      percentProgres=50;
      emit(UploadImageSuccessfullyState());
      value.ref.getDownloadURL().then((value) {
        imageURL=value;
        percentProgres=75;
        emit(DownloadImageURLSuccessfullyState());
        FirebaseFirestore.instance
            .collection("mnadeb-info")
            .doc(uId)
            .update({"name":name,"phone":phone,"image":imageURL})
            .then((value) {
              percentProgres=100;
              progressFlag=0;
              showToast(msg: "تم تعديل المندوب بنجاح", backgroundColor: Colors.green, textColor: Colors.white);
              emit(UpdateMandobInfoSuccessfullyState());
              percentProgres=0;
        });
      });
    }).catchError((error){
      emit(UpdateMandobInfoErrorState());
      print(error.toString());
    });
  }

  void editMandobInfo({required String phone, required String name, required String uId}){
    if(image==null){
      _editMandobInfoWithoutImage(phone: phone, name: name, uId: uId);
    }
    else {
      _editMandobInfoWithImage(phone: phone, name: name, uId: uId);
    }
  }
}
