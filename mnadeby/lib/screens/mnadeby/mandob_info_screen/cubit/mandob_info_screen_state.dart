part of 'mandob_info_screen_cubit.dart';

@immutable
abstract class MandobInfoScreenState {}

class MandobInfoScreenInitial extends MandobInfoScreenState {}

class DeleteMandobLoadingState extends MandobInfoScreenState {}

class DeleteMandobSuccessfullyState extends MandobInfoScreenState {}

class DeleteMandobErrorState extends MandobInfoScreenState {}
