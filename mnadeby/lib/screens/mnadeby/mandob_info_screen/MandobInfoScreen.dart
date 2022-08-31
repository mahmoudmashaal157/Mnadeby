import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/screens/layout_screen/LayoutScreen.dart';
import 'package:mnadeby/screens/mnadeby/edit_mandob_info/EditMandobInfo.dart';
import 'package:mnadeby/screens/mnadeby/mandob_info_screen/cubit/mandob_info_screen_cubit.dart';
import 'package:mnadeby/screens/mnadeby/mandob_orders_screen/mandobOrdersScreen.dart';
import 'package:mnadeby/screens/mnadeby/mandob_tracking_screen/MandobTrackingScreen.dart';
import 'package:mnadeby/screens/mnadeby/mnadeby_screen/cubit/mnadeby_screen_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class MandobInfoScreen extends StatelessWidget {
  late String name;
  late String phone;
  late String email;
  late String image;
  late String password;
  late String uId;

  MandobInfoScreen(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password,
      required this.image,
      required this.uId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "بيانات المندوب",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => MandobInfoScreenCubit(),
                        child: BlocConsumer<MandobInfoScreenCubit,
                            MandobInfoScreenState>(
                          listener: (context, state) {
                            if (state is DeleteMandobSuccessfullyState) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return LayoutScreen();
                              }));
                            }
                          },
                          builder: (context, state) {
                            MandobInfoScreenCubit cubit = MandobInfoScreenCubit.get(context);
                            return AlertDialog(
                              title: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text("هل انت متأكد من مسح المندوب")),
                              content: state is DeleteMandobLoadingState
                                  ? Container(
                                    child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                height: 100,
                                  )
                                  : Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("لا"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                          onPressed: () {
                                            cubit.deleteMandob(uId: uId, mandobName: name);
                                          },
                                          child: Text("نعم"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                        ),
                                      ],
                                    ),
                            );
                          },
                        ),
                      );
                    });
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10,),
            Center(
              child: Container(
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
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    "الاسم : $name  ",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff34a853),
                          shape: BoxShape.circle
                        ),
                        child: IconButton(
                            onPressed: () {
                              launch("tel://$phone");
                            },
                            icon: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "$phone",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      print(this.name);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MandobTrackingScreen(mandobId: uId,mandobNamee: this.name,);
                      }));
                    },
                    child: Text(
                      "تتبع المندوب",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MandobOrdersScreen(
                          mandobName: name,
                        );
                      }));
                    },
                    child: Text(
                      "اوردرات المندوب",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EditMandobInfo(
                            name: name,
                            phone: phone,
                            email: email,
                            password: password,
                            image: image,
                            uId: uId);
                      }));
                    },
                    child: Text(
                      "تعديل بيانات المندوب",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
