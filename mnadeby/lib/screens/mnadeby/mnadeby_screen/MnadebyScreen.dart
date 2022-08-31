import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mnadeby/models/MandobInfoModel.dart';
import 'package:mnadeby/screens/mnadeby/add_mandob/AddMandobScreen.dart';
import 'package:mnadeby/screens/mnadeby/mandob_info_screen/MandobInfoScreen.dart';
import 'package:mnadeby/screens/mnadeby/mandob_orders_screen/cubit/mandob_orders_screen_cubit.dart';
import 'package:mnadeby/screens/mnadeby/mnadeby_screen/cubit/mnadeby_screen_cubit.dart';

class MnadebyScreen extends StatelessWidget {
  List<String> names = ["محمد احمد", "احمد علي", "محمود خالد سمير احمد راغب"];
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MnadebyScreenCubit()
        ..getMnadeby(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "مناديبي",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        floatingActionButton: BlocBuilder<MnadebyScreenCubit,
            MnadebyScreenState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return AddMandob();
                    })).then((value) {
                  MnadebyScreenCubit.get(context).getMnadeby();
                });
              },
              child: Icon(Icons.add),
            );
          },
        ),
        body: BlocBuilder<MnadebyScreenCubit, MnadebyScreenState>(
          builder: (context, state) {
            MnadebyScreenCubit cubit = MnadebyScreenCubit.get(context);
            List<MandobInfoModel>mnadeby = [];
            mnadeby = cubit.mnadeby;
            return state is GetMnadebyLoadingState ?
            Center(child: CircularProgressIndicator()) :
            ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return MandobBuilder(
                    name: mnadeby[index].name.toString(),
                    image: mnadeby[index].image.toString(),
                    phone: mnadeby[index].phone.toString(),
                    password: mnadeby[index].password.toString(),
                    email: mnadeby[index].email.toString(),
                    uId: mnadeby[index].uId.toString(),
                  );
                },
                itemCount: mnadeby.length);
          },
        ),
      ),
    );
  }
}

class MandobBuilder extends StatelessWidget {
  late String name;
  late String phone;
  late String password;
  late String image;
  late String email;
  late String uId;

  MandobBuilder(
      {required this.name, required this.image, required this.phone, required this.password, required this.email, required this.uId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MnadebyScreenCubit, MnadebyScreenState>(
      builder: (context, state) {
        return InkWell(
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "$image",
                      height: 180,
                      width: 180,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      fadeInCurve: Curves.elasticIn,
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    "$name",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return MandobInfoScreen(
                    name: name,
                    phone: phone,
                    email: email,
                    password: password,
                    image: image,
                    uId: uId,
                  );
                })).then((value) {
                  MnadebyScreenCubit.get(context).getMnadeby();
            });
          },
        );
      },
    );
  }
}
