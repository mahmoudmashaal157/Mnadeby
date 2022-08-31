import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/screens/mnadeby/mnadeby_screen/MnadebyScreen.dart';
import 'package:mnadeby/screens/money/money_screen/MoneyScreen.dart';
import 'package:mnadeby/screens/orders/orders_screen/OrdersScreen.dart';

import 'cubit/layout_screen_cubit.dart';

class LayoutScreen extends StatelessWidget {
  List<Widget>screens=[MnadebyScreen(),OrdersScreen(),MoneyScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutScreenCubit(),
      child: BlocBuilder<LayoutScreenCubit, LayoutScreenState>(
        builder: (context, state) {
          LayoutScreenCubit cubit = LayoutScreenCubit.get(context);
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.delivery_dining),
                    label: "مناديبي"
                ),
                BottomNavigationBarItem(icon: Icon(Icons.wb_twilight),
                    label: "اوردرات"
                ),
                BottomNavigationBarItem(icon: Icon(Icons.money),
                    label: "تحصيلات"
                ),
              ],
              currentIndex:cubit.curIndex ,
              onTap: (int index){
                cubit.changeIndex(index);
              },
            ),
            body: screens[cubit.curIndex],
          );
        },
      ),
    );
  }
}
