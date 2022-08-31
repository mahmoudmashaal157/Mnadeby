import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/models/OrderModel.dart';
import 'package:mnadeby/screens/mnadeby/mandob_orders_screen/cubit/mandob_orders_screen_cubit.dart';
import 'package:mnadeby/screens/orders/order_details_screen/OrderDetailsScreen.dart';

class MandobOrdersScreen extends StatelessWidget {

  late String mandobName;

  MandobOrdersScreen({required this.mandobName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MandobOrdersScreenCubit()
        ..getDateNow()
        ..getMandobOrders(mandobName: mandobName),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("$mandobName",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<MandobOrdersScreenCubit, MandobOrdersScreenState>(
              builder: (context, state) {
                MandobOrdersScreenCubit cubit = MandobOrdersScreenCubit.get(
                    context);
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32
                              ),
                            ),
                          ),
                          //Spacer(),
                          Icon(Icons.arrow_drop_down, size: 30,),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime.parse("3000-12-30")).then((value) {
                      if (value != null) {
                        cubit.changeDate(value);
                        cubit.getMandobOrders(mandobName: mandobName);
                      }
                    });
                  },
                );
              },
            ),
            BlocBuilder<MandobOrdersScreenCubit, MandobOrdersScreenState>(
              builder: (context, state) {
                MandobOrdersScreenCubit cubit = MandobOrdersScreenCubit.get(context);
                return state is GetMandobOrdersLoadingState? Center(child: CircularProgressIndicator()) : Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return OrderBuilder(orderInfo:cubit.mandobOrdersList[index]);
                      },
                      itemCount: cubit.mandobOrdersList.length,
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderBuilder extends StatelessWidget {

  late OrderModel orderInfo;
  int? color;

  OrderBuilder({required this.orderInfo});

  @override
  Widget build(BuildContext context) {

    if (orderInfo.status == "لم يتم التوصيل") {
      color = 0xffb50027;
    }
    else if (orderInfo.status == "تم التوصيل") {
      color = 0xff388d5d;
    }
    else {
      color = 0xffd8a24a;
    }

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          color: Color(color!),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(thickness: 2, color: Colors.white,),
                Center(
                  child: Text("${orderInfo.orderNumber}",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
                Divider(thickness: 2, color: Colors.white,),
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("${orderInfo.status}",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(width: 5,),
                        VerticalDivider(color: Colors.white, thickness: 2),
                        Expanded(
                          child:
                          Text(
                            "${orderInfo.orderAddress}",
                            maxLines: 4,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white
                            ),
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
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return OrderDetailsScreen(orderInfo: orderInfo);
        }));
      },
    );
  }
}

//0xffb50027
///0xff388d5d
//0xffd8a24a