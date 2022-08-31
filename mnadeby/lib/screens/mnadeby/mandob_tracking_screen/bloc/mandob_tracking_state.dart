part of 'mandob_tracking_bloc.dart';

@immutable
abstract class MandobTrackingState {}

class MandobTrackingInitial extends MandobTrackingState {}

class GetMandobTrackingLoadingState extends MandobTrackingState {}

class GetMandobTrackingSuccessfullyState extends MandobTrackingState {}

class GetMandobTrackingErrorState extends MandobTrackingState {}