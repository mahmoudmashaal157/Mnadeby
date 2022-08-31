part of 'add_order_screen_cubit.dart';

@immutable
abstract class AddOrderScreenState {}

class AddOrderScreenInitial extends AddOrderScreenState {}

class ChangeNameOfMandobState extends AddOrderScreenState {}

class AddNewOrderLoadingState extends AddOrderScreenState {}

class AddNewOrderSuccessfullyState extends AddOrderScreenState {}

class AddNewOrderErrorState extends AddOrderScreenState {}

class ChangeDateState extends AddOrderScreenState {}
