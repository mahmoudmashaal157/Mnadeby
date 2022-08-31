import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'layout_screen_state.dart';

class LayoutScreenCubit extends Cubit<LayoutScreenState> {
  LayoutScreenCubit() : super(LayoutScreenInitial());

  static LayoutScreenCubit get(BuildContext context)=>BlocProvider.of(context);
  int curIndex=0;

  void changeIndex(int index){
    curIndex = index;
    emit(ChangeNavBarIndex());
  }
}
