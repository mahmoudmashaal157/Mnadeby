import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAndPasswordMandob extends StatelessWidget {
  late String password;
  late String email;

  EmailAndPasswordMandob({required this.password, required this.email});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(" ايميل و باسورد المندوب",
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text("الايميل :\n $email",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            child: Card(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text("الباسورد :\n $password",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
