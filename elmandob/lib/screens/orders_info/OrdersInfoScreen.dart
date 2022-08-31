import 'package:elmandob/models/OrderModel.dart';
import 'package:elmandob/screens/orders_info/cubit/orders_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersInfoScreen extends StatelessWidget {
  late OrderModel orderInfo;

  OrdersInfoScreen({required this.orderInfo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersInfoCubit(),
      child: Scaffold(
        backgroundColor: Color(0xffe5e5e5),
        appBar: AppBar(
          title: Center(
            child: Text(
              "اوردرات اليوم",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(color: Colors.black, thickness: 2),
                          Center(
                              child: Text(
                            "رقم الاوردر : ${orderInfo.orderNumber}",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          )),
                          Divider(color: Colors.black, thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(color: Colors.black, thickness: 2),
                          Center(
                              child: Text(
                            "العنوان",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          )),
                          Divider(color: Colors.black, thickness: 2),
                          Text(
                            "${orderInfo.orderAddress}",
                            style: TextStyle(
                              fontSize: 32,
                            ),
                            textDirection: TextDirection.rtl,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(color: Colors.black, thickness: 2),
                          Center(
                              child: Text(
                            " العميل الهيوصله الاوردر",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                            textDirection: TextDirection.rtl,
                          )),
                          Divider(color: Colors.black, thickness: 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${orderInfo.orderNewOwnerName}",
                                style: TextStyle(fontSize: 32),
                              ),
                              Row(
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
                                              launch(
                                                  "tel://${orderInfo.orderNewOwnerNumber}");
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
                                      "${orderInfo.orderNewOwnerNumber}",
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(color: Colors.black, thickness: 2),
                          Center(
                              child: Text(
                            " العميل صاحب الاوردر",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                            textDirection: TextDirection.rtl,
                          )),
                          Divider(color: Colors.black, thickness: 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${orderInfo.orderOwnerName}",
                                style: TextStyle(fontSize: 32),
                              ),
                              Row(
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
                                              launch(
                                                  "tel://${orderInfo.orderOwnerNumber}");
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
                                      "${orderInfo.orderOwnerNumber}",
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.black,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(color: Colors.black, thickness: 2),
                          Center(
                              child: Text(
                            "التوصيل : ${orderInfo.deliveryPrice} جنيه",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          )),
                          Divider(color: Colors.black, thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Divider(color: Colors.black, thickness: 2),
                          Center(
                              child: Text(
                            "لوكيشن",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          )),
                          Divider(color: Colors.black, thickness: 2),
                          InkWell(
                            child: Text(
                              "${orderInfo.location}",
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: (){
                              launch(orderInfo.location!);

                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocConsumer<OrdersInfoCubit, OrdersInfoState>(
                  listener: (context, state) {
                    if (state is UpdateOrderStatusSuccessfullyState) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    OrdersInfoCubit cubit = OrdersInfoCubit.get(context);
                    return state is UpdateOrderStatusLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : orderInfo.status == "تم التوصيل"
                            ? Container()
                            : Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 60,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.updateStatusOfTheOrder(
                                            status: "تم التوصيل",
                                            orderNumber: orderInfo.orderNumber
                                                .toString());
                                      },
                                      child: Text(
                                        "تم التوصيل",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff388d5d),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 60,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.updateStatusOfTheOrder(
                                            status: "جاري التوصيل",
                                            orderNumber: orderInfo.orderNumber
                                                .toString());
                                      },
                                      child: Text(
                                        "جاري التوصيل ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xffd8a24a),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 60,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.updateStatusOfTheOrder(
                                            status: "لم يتم التوصيل",
                                            orderNumber: orderInfo.orderNumber
                                                .toString());
                                      },
                                      child: Text(
                                        "لم يتم التوصيل",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xffb50027),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                  )),
                                ],
                              );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
