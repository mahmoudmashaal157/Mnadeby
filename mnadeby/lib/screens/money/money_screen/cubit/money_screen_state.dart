part of 'money_screen_cubit.dart';

@immutable
abstract class MoneyScreenState {}

class MoneyScreenInitial extends MoneyScreenState {}

class ChangeDateState extends MoneyScreenState {}

class CollectMnadebMoneyLoadingState extends MoneyScreenState {}

class CollectMnadebMoneySuccessfullyState extends MoneyScreenState {}

class CollectMnadebMoneyErrorState extends MoneyScreenState {}
