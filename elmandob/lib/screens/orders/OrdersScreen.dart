import 'package:elmandob/models/OrderModel.dart';
import 'package:elmandob/screens/orders/cubit/orders_cubit.dart';
import 'package:elmandob/screens/orders_info/OrdersInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()
        ..getDateNow()
        ..getMandobOrders(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          OrdersCubit cubit = OrdersCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xffe5e5e5),
            appBar: AppBar(
              title: Center(
                child: Text(
                  "اوردرات اليوم",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            body: state is GetMandobOrdersLoadingState
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh:() => cubit.getMandobOrders(),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return OrderBuilder(
                              orderInfo: cubit.mandobOrders[index],
                            );
                          },
                          itemCount: cubit.mandobOrders.length,
                        ),
                      ),
                    ),
                  ],
                ),
          );
        },
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
    return InkWell(
      child: Card(
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
                      VerticalDivider(color: Colors.white, thickness: 2),
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
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return OrdersInfoScreen(
            orderInfo: orderInfo,
          );
        })).then((value) {
          OrdersCubit.get(context).getMandobOrders();
        });
      },
    );
  }
}
