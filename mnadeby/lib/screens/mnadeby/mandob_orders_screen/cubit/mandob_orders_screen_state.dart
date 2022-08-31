part of 'mandob_orders_screen_cubit.dart';

@immutable
abstract class MandobOrdersScreenState {}

class MandobOrdersScreenInitial extends MandobOrdersScreenState {}

class ChangeDateState extends MandobOrdersScreenState {}

class GetMandobOrdersLoadingState extends MandobOrdersScreenState {}

class GetMandobOrdersSuccessfullyState extends MandobOrdersScreenState {}

class GetMandobOrdersErrorState extends MandobOrdersScreenState {}
