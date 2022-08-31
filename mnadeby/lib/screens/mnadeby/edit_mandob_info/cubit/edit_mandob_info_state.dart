part of 'edit_mandob_info_cubit.dart';

@immutable
abstract class EditMandobInfoState {}

class EditMandobInfoInitial extends EditMandobInfoState {}

class PickImageFromGallerySuccessfullyState extends EditMandobInfoState {}

class UpdateMandobInfoLoadingState extends EditMandobInfoState {}

class UpdateMandobInfoSuccessfullyState extends EditMandobInfoState {}

class UpdateMandobInfoErrorState extends EditMandobInfoState {}

class UploadImageSuccessfullyState extends EditMandobInfoState {}

class DownloadImageURLSuccessfullyState extends EditMandobInfoState {}

