import 'package:elmandob/screens/log_in/cubit/LoginCubit.dart';
import 'package:elmandob/screens/log_in/cubit/LoginState.dart';
import 'package:elmandob/screens/orders/OrdersScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  LoginCubit cubit = LoginCubit.get(context);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: cubit.passwordVisiblity,
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: "الباسورد",
                            border: OutlineInputBorder(),
                            hintText: "الباسورد",
                            suffixIcon: cubit.passwordVisiblity == true
                                ? IconButton(
                                    onPressed: () {
                                      cubit.changePasswordVisiblity();
                                    },
                                    icon: Icon(Icons.visibility))
                                : IconButton(
                                    onPressed: () {
                                      cubit.changePasswordVisiblity();
                                    },
                                    icon: Icon(Icons.visibility_off))),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "لا يمكن ان يكون الايميل فارغ";
                          }
                          return null;
                        },
                      ),
                    ),
                  );
                },
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if(state is LoginSuccessfullyState){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                      return OrdersScreen();
                    }));
                  }
                },
                builder: (context, state) {
                  LoginCubit cubit = LoginCubit.get(context);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              cubit.mandobLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          child: state is LoginLoadingState
                              ? Center(child: CircularProgressIndicator(color: Colors.white,))
                              : Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
