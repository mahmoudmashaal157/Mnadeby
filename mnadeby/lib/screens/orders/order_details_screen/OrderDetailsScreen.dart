import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/models/OrderModel.dart';
import 'package:mnadeby/screens/orders/order_details_screen/cubit/order_details_screen_cubit.dart';
import 'package:mnadeby/shared/components/data.dart';

String? mandobName;

class OrderDetailsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  late OrderModel orderInfo;
  TextEditingController orderNumberController = TextEditingController();
  TextEditingController orderAddressController = TextEditingController();
  TextEditingController orderOwnerNameController = TextEditingController();
  TextEditingController orderOwnerNumberController = TextEditingController();
  TextEditingController orderNewOwnerNameController = TextEditingController();
  TextEditingController orderNewOwnerNumberController = TextEditingController();
  TextEditingController deliveryPriceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  OrderDetailsScreen({required this.orderInfo});

  @override
  Widget build(BuildContext context) {
    mandobName = orderInfo.mandobName;
    orderNumberController.text = orderInfo.orderNumber.toString();
    orderAddressController.text = orderInfo.orderAddress.toString();
    orderOwnerNameController.text = orderInfo.orderOwnerName.toString();
    orderOwnerNumberController.text = orderInfo.orderOwnerNumber.toString();
    orderNewOwnerNameController.text = orderInfo.orderNewOwnerName.toString();
    orderNewOwnerNumberController.text = orderInfo.orderNewOwnerNumber.toString();
    deliveryPriceController.text = orderInfo.deliveryPrice.toString();
    dateController.text = orderInfo.date.toString();
    locationController.text = orderInfo.location.toString();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "بيانات اوردر",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderDetailsScreenCubit()..checkMandobName(mandobName: mandobName!),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "رقم الاوردر : ${orderInfo.orderNumber}",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: orderAddressController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "عنوان الاوردر",
                        border: OutlineInputBorder(),
                        hintText: "عنوان الاوردر",
                      ),
                      minLines: 1,
                      maxLines: 10,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون عنوان الاوردر فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: orderOwnerNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "اسم العميل صاحب الاوردر",
                        border: OutlineInputBorder(),
                        hintText: "اسم العميل صاحب الاوردر",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون اسم العميل صاحب الاوردر فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: orderOwnerNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "رقم العميل صاحب الاوردر",
                        border: OutlineInputBorder(),
                        hintText: "رقم العميل صاحب الاوردر",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون رقم العميل صاحب الاوردر فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: orderNewOwnerNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "اسم العميل الرايحله الاوردر",
                        border: OutlineInputBorder(),
                        hintText: "اسم العميل الرايحله الاوردر",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون اسم العميل الرايحله الاوردر فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: orderNewOwnerNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "رقم العميل الرايحله الاوردر",
                        border: OutlineInputBorder(),
                        hintText: "رقم العميل الرايحله الاوردر",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون رقم العميل الرايحله الاوردر فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: BlocBuilder<OrderDetailsScreenCubit,
                        OrderDetailsScreenState>(
                      builder: (context, state) {
                        OrderDetailsScreenCubit cubit =
                        OrderDetailsScreenCubit.get(context);
                        return orderInfo.status == "تم التوصيل"?
                        Container(
                          width: double.infinity,
                          child: Card(
                            child: RichText(
                              text: TextSpan(
                                  text: " اسم المندوب : ",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "${orderInfo.mandobName}",
                                        style: TextStyle(
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ) :
                        DropdownButton(
                            onTap: () {},
                            isExpanded: true,
                            hint: Text("بدون مندوب"),
                            value: cubit.mandobName,
                            items: mnadebNames.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              mandobName = newValue;
                              cubit.changeMandobName(newValue!);
                            });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: deliveryPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "سعر التوصيل",
                        border: OutlineInputBorder(),
                        hintText: "سعر التوصيل",
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "لا يمكن ان يكون سعر التوصيل فارغ";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                BlocBuilder<OrderDetailsScreenCubit, OrderDetailsScreenState>(
                  builder: (context, state) {
                    OrderDetailsScreenCubit cubit = OrderDetailsScreenCubit.get(
                        context);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: dateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "التاريخ",
                            border: OutlineInputBorder(),
                            hintText: "التاريخ",
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
                                dateController.text = cubit.date!;
                              }
                            });
                          },
                          readOnly: true,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "لا يمكن ان يكون التاريخ التوصيل فارغ";
                            }
                            return null;
                          },
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: locationController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "لوكيشن",
                        border: OutlineInputBorder(),
                        hintText: "لوكيشن",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<
                        OrderDetailsScreenCubit,
                        OrderDetailsScreenState>(
                      builder: (context, state) {
                        OrderDetailsScreenCubit cubit = OrderDetailsScreenCubit
                            .get(context);
                        return orderInfo.status=="تم التوصيل"?
                        Container():
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.updateOrderInfo(
                                  orderNumber: orderInfo.orderNumber!,
                                  orderAddress: orderAddressController.text,
                                  orderOwnerName: orderOwnerNameController.text,
                                  orderOwnerNumber: orderOwnerNumberController.text,
                                  orderNewOwnerName: orderNewOwnerNameController.text,
                                  orderNewOwnerNumber: orderNewOwnerNumberController.text,
                                  mandobName: mandobName!,
                                  deliveryPrice: double.parse(deliveryPriceController.text),
                                newDate : dateController.text,
                                oldDate: orderInfo.date!,
                                location: locationController.text
                              );
                            }
                          },
                          child: state is UpdateOrderInfoLoadingState? Center(child: CircularProgressIndicator(color: Colors.white,))
                              : Text(
                            "تعديل",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

