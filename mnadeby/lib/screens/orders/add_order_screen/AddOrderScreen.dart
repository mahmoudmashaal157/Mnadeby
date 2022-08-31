import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/screens/mnadeby/add_mandob/cubit/add_mandob_screen_cubit.dart';
import 'package:mnadeby/screens/orders/add_order_screen/cubit/add_order_screen_cubit.dart';
import 'package:mnadeby/shared/components/data.dart';

class AddOrderScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  TextEditingController orderNumberController = TextEditingController();
  TextEditingController orderAddressController = TextEditingController();
  TextEditingController orderOwnerNameController = TextEditingController();
  TextEditingController orderOwnerNumberController = TextEditingController();
  TextEditingController orderNewOwnerNameController = TextEditingController();
  TextEditingController orderNewOwnerNumberController = TextEditingController();
  TextEditingController deliveryPriceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String mandobName = mnadebNames[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("اضافة اوردر",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

      ),
      body: BlocProvider(
        create: (context) => AddOrderScreenCubit()..getDateNow(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                BlocBuilder<AddOrderScreenCubit, AddOrderScreenState>(
                  builder: (context, state) {
                    AddOrderScreenCubit cubit = AddOrderScreenCubit.get(context);
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
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("3000-12-30")).then((value) {
                          if(value!=null){
                            cubit.changeDate(value);
                          }
                        });
                      },
                    );
                  },
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
                    child: BlocBuilder<AddOrderScreenCubit,
                        AddOrderScreenState>(
                      builder: (context, state) {
                        AddOrderScreenCubit cubit = AddOrderScreenCubit.get(
                            context);
                        return DropdownButton(
                            onTap: () {},
                            isExpanded: true,
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
                              cubit.changeMandobName(newValue!);
                              mandobName = newValue;
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
                BlocConsumer<AddOrderScreenCubit, AddOrderScreenState>(
                  listener: (context, state) {
                    if(state is AddNewOrderSuccessfullyState){
                      orderAddressController.text="";
                      orderOwnerNameController.text="";
                      orderOwnerNumberController.text="";
                      orderNewOwnerNameController.text="";
                      orderNewOwnerNumberController.text="";
                      deliveryPriceController.text="";
                      locationController.text="";
                    }
                  },
                  builder: (context, state) {
                    AddOrderScreenCubit cubit = AddOrderScreenCubit.get(context);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.addNewOrder(
                                  orderAddress: orderAddressController.text,
                                  orderOwnerName: orderOwnerNameController.text,
                                  orderOwnerNumber: orderOwnerNumberController.text,
                                  orderNewOwnerName: orderNewOwnerNameController.text,
                                  orderNewOwnerNumber: orderNewOwnerNumberController.text,
                                  mandobName: mandobName,
                                  deliveryPrice: double.parse(deliveryPriceController.text),
                                  location: locationController.text);
                            }
                          },
                          child: state is AddNewOrderLoadingState ?
                          Center(child: CircularProgressIndicator(
                            color: Colors.white,)) :
                          Text(
                            "اضافة",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
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
