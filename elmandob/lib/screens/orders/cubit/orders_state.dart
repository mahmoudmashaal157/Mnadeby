part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class GetMandobOrdersLoadingState extends OrdersState {}

class GetMandobOrdersSuccessfullyState extends OrdersState {}

class GetMandobOrdersErrorState extends OrdersState {}
