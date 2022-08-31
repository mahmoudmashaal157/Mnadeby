import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/screens/layout_screen/LayoutScreen.dart';
import 'package:mnadeby/screens/mnadeby/edit_mandob_info/cubit/edit_mandob_info_cubit.dart';
import 'package:mnadeby/screens/mnadeby/email_and_password_mandob/EmailAndPasswordMandob.dart';
import 'package:mnadeby/screens/mnadeby/mnadeby_screen/MnadebyScreen.dart';

class EditMandobInfo extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
  late String name;
  late String phone;
  late String email;
  late String image;
  late String password;
  late String uId;

  EditMandobInfo(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password,
      required this.image,
      required this.uId});
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    phoneController.text = phone;
    nameController.text = name;
    return BlocProvider(
      create: (context) => EditMandobInfoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("تعديل بيانات مندوب",
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                BlocBuilder<EditMandobInfoCubit, EditMandobInfoState>(
                  builder: (context, state) {
                    EditMandobInfoCubit cubit = EditMandobInfoCubit.get(context);
                    return Center(
                      child: InkWell(
                        child: cubit.image==null?
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Image.network(
                            "$image",
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ):
                        Container(
                          width: 200,
                          height: 200,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: cubit.image == null
                                  ? AssetImage("assets/images/add.jpg")
                                  : FileImage(cubit.image!) as ImageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: (){
                          cubit.selectImageFromGallery();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "الاسم",
                        border: OutlineInputBorder(),
                        hintText: "الاسم",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون الاسم فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "الرقم",
                        border: OutlineInputBorder(),
                        hintText: "الرقم",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون الرقم فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                BlocConsumer<EditMandobInfoCubit, EditMandobInfoState>(
                  listener: (context, state) {
                    if(state is UpdateMandobInfoSuccessfullyState){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                        return LayoutScreen();
                      }));
                    }
                  },
                  builder: (context, state) {
                    EditMandobInfoCubit cubit = EditMandobInfoCubit.get(context);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: cubit.progressFlag == 0
                            ? ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.editMandobInfo(phone: phoneController.text, name: nameController.text, uId: uId);
                                  }
                                },
                                child: Text(
                                  "تعديل",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.red,
                                    minHeight: 5,
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        Color(0xff34a853)),
                                    value: (cubit.percentProgres / 100),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "${cubit.percentProgres}%",
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          var formKey = GlobalKey<FormState>();
                          String password = "123456";
                          return AlertDialog(
                            title: Text("من فضلك ادخل باسورد الادمن",
                              style: TextStyle(fontSize: 24),
                            textDirection: TextDirection.rtl,
                            ),
                            content:SingleChildScrollView(
                              child: Container(
                                height: 150,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: adminPasswordController,
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: "الباسورد",
                                          border: OutlineInputBorder(),
                                          hintText: "الباسورد",
                                        ),
                                        validator: (text) {
                                          if (text!=password) {
                                            return "خطأ في الباسورد";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        child: ElevatedButton(
                                            onPressed: (){
                                              if(formKey.currentState!.validate()){
                                                adminPasswordController.text="";
                                                Navigator.pop(context);
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                                  return EmailAndPasswordMandob(password: this.password, email: email);
                                                }));
                                              }
                                            },
                                            child: Text("ادخل")
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ) ,
                          );
                        });
                      },
                      child: Text(
                        "الايميل و الباسورد",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
