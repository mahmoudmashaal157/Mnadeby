import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/models/OrderModel.dart';
import 'package:mnadeby/screens/orders/add_order_screen/AddOrderScreen.dart';
import 'package:mnadeby/screens/orders/order_details_screen/OrderDetailsScreen.dart';
import 'package:mnadeby/screens/orders/orders_screen/cubit/orders_screen_cubit.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersScreenCubit()
        ..getDateNow()
        ..getAllOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "اوردرات اليوم",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<OrdersScreenCubit, OrdersScreenState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AddOrderScreen();
                })).then((value) {
                  OrdersScreenCubit.get(context).getAllOrders();
                });
              },
              child: Icon(Icons.add),
            );
          },
        ),
        body: Column(
          children: [
            BlocBuilder<OrdersScreenCubit, OrdersScreenState>(
              builder: (context, state) {
                OrdersScreenCubit cubit = OrdersScreenCubit.get(context);
                return InkWell(
                  child: Container(
                    height: 80,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "${cubit.date}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32),
                            ),
                          ),
                          //Spacer(),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: (DateTime(2022)),
                            lastDate: DateTime.parse("3000-12-30"))
                        .then((value) {
                      if (value != null) {
                        cubit.changeDate(value);
                        cubit.getAllOrders();
                      }
                    });
                  },
                );
              },
            ),
            Expanded(child: BlocBuilder<OrdersScreenCubit, OrdersScreenState>(
              builder: (context, state) {
                OrdersScreenCubit cubit = OrdersScreenCubit.get(context);
                return state is GetAllOrdersLoadingState ||
                        state is DeleteOrderLoadingState
                    ? Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () => cubit.getAllOrders(),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return OrderBuilder(
                              orderInfo: cubit.ordersList[index],
                            );
                          },
                          itemCount: cubit.ordersList.length,
                        ),
                      );
              },
            )),
          ],
        ),
      ),
    );
  }
}

class OrderBuilder extends StatelessWidget {
  late OrderModel orderInfo;
  late int color;

  OrderBuilder({required this.orderInfo});

  @override
  Widget build(BuildContext context) {
    if (orderInfo.status == "لم يتم التوصيل") {
      color = 0xffb50027;
    } else if (orderInfo.status == "تم التوصيل") {
      color = 0xff388d5d;
    } else {
      color = 0xffd8a24a;
    }
    return orderInfo.status == "تم التوصيل"
        ? InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(color),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      Center(
                        child: Text(
                          "${orderInfo.orderNumber}",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "${orderInfo.status}",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              VerticalDivider(
                                  color: Colors.white, thickness: 2),
                              Expanded(
                                child: Text(
                                  "${orderInfo.orderAddress}",
                                  maxLines: 4,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return OrderDetailsScreen(
                  orderInfo: orderInfo,
                );
              })).then((value) {
                OrdersScreenCubit.get(context).getAllOrders();
              });
            },
          )
        : Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              OrdersScreenCubit.get(context).deleteOrder(
                  date: orderInfo.date.toString(),
                  orderNumber: orderInfo.orderNumber.toString());
            },
            background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                size: 50,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                size: 50,
                color: Colors.white,
              ),
            ),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(color),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        Center(
                          child: Text(
                            "${orderInfo.orderNumber}",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "${orderInfo.status}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                VerticalDivider(
                                    color: Colors.white, thickness: 2),
                                Expanded(
                                  child: Text(
                                    "${orderInfo.orderAddress}",
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return OrderDetailsScreen(
                    orderInfo: orderInfo,
                  );
                })).then((value) {
                  OrdersScreenCubit.get(context).getAllOrders();
                });
              },
            ),
          );
  }
}

///0xffb50027
///0xff388d5d
///0xffd8a24a
