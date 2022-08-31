import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/screens/mnadeby/add_mandob/cubit/add_mandob_screen_cubit.dart';
import 'package:mnadeby/shared/components/toast/toast.dart';

class AddMandob extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "اضافة مندوب",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => AddMandobScreenCubit(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Center(
                  child: BlocBuilder<AddMandobScreenCubit,
                      AddMandobScreenState>(
                    builder: (context, state) {
                      AddMandobScreenCubit cubit = AddMandobScreenCubit.get(
                          context);
                      return InkWell(
                        child: cubit.image == null ?
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Icon(
                            Icons.camera_alt, size: 100,
                            color: Color(0xff34a853),),
                        )
                            : Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: cubit.image == null
                                  ? AssetImage("assets/images/add.jpg")
                                  : FileImage(cubit.image!) as ImageProvider,
                              fit: BoxFit.fill,
                            ),),
                        ),
                        onTap: () {
                          cubit.selectImageFromGallery();
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "الايميل",
                        border: OutlineInputBorder(),
                        hintText: "الايميل",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون الايميل فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                BlocBuilder<AddMandobScreenCubit, AddMandobScreenState>(
                  builder: (context, state) {
                    AddMandobScreenCubit cubit = AddMandobScreenCubit.get(
                        context);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.passwordVisiblity,
                          decoration: InputDecoration(
                              labelText: "باسورد",
                              border: OutlineInputBorder(),
                              hintText: "باسورد",
                              suffixIcon: cubit.passwordVisiblity == true ?
                              IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisiblity();
                                  },
                                  icon: Icon(Icons.visibility)
                              ) :
                              IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisiblity();
                                  },
                                  icon: Icon(Icons.visibility_off)
                              )
                          ),
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "لا يمكن ان يكون باسورد فارغ";
                            }
                            return null;
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20,),
                BlocConsumer<AddMandobScreenCubit, AddMandobScreenState>(
                  listener: (context, state) {
                    if(state is AddMandobInfoSuccessfullyState){
                      nameController.text="";
                      phoneController.text="";
                      emailController.text="";
                      passwordController.text="";
                      AddMandobScreenCubit.get(context).image=null;
                    }
                  },
                  builder: (context, state) {
                    AddMandobScreenCubit cubit = AddMandobScreenCubit.get(context);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: cubit.progressFlag==0?
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if(cubit.image==null){
                                showToast(msg: "لا يمكن ل صورة المندوب ان تكون فارغه", backgroundColor: Colors.red, textColor: Colors.white);
                              }
                              else{
                                cubit.addMandob(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text
                                );
                              }
                            }
                          },
                          child: Text(
                            "اضافة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                        ):
                        Column(
                          children: [
                            LinearProgressIndicator(
                              backgroundColor: Colors.red,
                              minHeight: 5,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xff34a853)),
                              value: (cubit.progressPercent/100),
                            ),
                            SizedBox(height: 8,),
                            Text("${cubit.progressPercent}%",style: const TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
