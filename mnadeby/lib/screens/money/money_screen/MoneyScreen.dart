import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/screens/mnadeby/mandob_orders_screen/mandobOrdersScreen.dart';
import 'package:mnadeby/screens/money/money_screen/cubit/money_screen_cubit.dart';

class MoneyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("تحصيلات اليوم",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
        MoneyScreenCubit()
          ..getDateNow()
          ..collectMoneyFromMnadeb(),
        child: BlocBuilder<MoneyScreenCubit, MoneyScreenState>(
          builder: (context, state) {
            MoneyScreenCubit cubit = MoneyScreenCubit.get(context);
            return state is CollectMnadebMoneyLoadingState? Center(child: CircularProgressIndicator(),) :
            Column(
              children: [
                InkWell(
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
                        cubit.collectMoneyFromMnadeb();
                      }
                    });
                  },
                ),
                SizedBox(height: 8,),
                Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return PriceBuilder(
                          name: cubit.mnadebMoneyList[index].name.toString(),
                          money: cubit.mnadebMoneyList[index].money.toString(),
                        );
                      },
                      itemCount: cubit.mnadebMoneyList.length,
                    )
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Center(
                      child: Text("الاجمالي :${cubit.total}",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class PriceBuilder extends StatelessWidget {

  late String name;
  late String money;

  PriceBuilder({required this.name,required this.money});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text("$money",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                VerticalDivider(thickness: 2,),
                Expanded(
                  child: Text("$name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return MandobOrdersScreen(mandobName: name);
        }));
      },
    );
  }
}

