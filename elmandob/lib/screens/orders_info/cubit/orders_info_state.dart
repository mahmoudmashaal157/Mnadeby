part of 'orders_info_cubit.dart';

@immutable
abstract class OrdersInfoState {}

class OrdersInfoInitial extends OrdersInfoState {}

class UpdateOrderStatusLoadingState extends OrdersInfoState {}

class UpdateOrderStatusSuccessfullyState extends OrdersInfoState {}

class UpdateOrderStatusErrorState extends OrdersInfoState {}
