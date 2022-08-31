part of 'orders_screen_cubit.dart';

@immutable
abstract class OrdersScreenState {}

class OrdersScreenInitial extends OrdersScreenState {}

class ChangeDateState extends OrdersScreenState {}

class GetAllOrdersLoadingState extends OrdersScreenState {}

class GetAllOrdersSuccessfullyState extends OrdersScreenState {}

class GetAllOrdersErrorState extends OrdersScreenState {}

class DeleteOrderLoadingState extends OrdersScreenState {}

class DeleteOrderSuccessfullyState extends OrdersScreenState {}

class DeleteOrderErrorState extends OrdersScreenState {}
