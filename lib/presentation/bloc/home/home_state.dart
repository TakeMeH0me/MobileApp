part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeEmpty extends HomeState {}

final class CreateHomeFetching extends HomeState {}

final class CreateHomeSuccess extends HomeState {}

final class CreateHomeError extends HomeState {
  final String message;

  const CreateHomeError({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteHomeFetching extends HomeState {}

final class DeleteHomeSuccess extends HomeState {}

final class DeleteHomeError extends HomeState {
  final String message;

  const DeleteHomeError({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateHomeFetching extends HomeState {}

final class UpdateHomeSuccess extends HomeState {}

final class UpdateHomeError extends HomeState {
  final String message;

  const UpdateHomeError({required this.message});

  @override
  List<Object> get props => [message];
}
