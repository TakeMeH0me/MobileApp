import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  List<HomeEntity> currentHomes = [];
  StreamSubscription<List<HomeEntity>>? homeStream2;

  HomeBloc({required this.homeRepository}) : super(HomeEmpty()) {
    test();

    on<CreateHomeEvent>(_handleCreateHome);
    on<GetAllHomesEvent>(_handleGetAllHomes);
    on<UpdateHomeEvent>(_handleUpdateHome);
    on<DeleteHomeEvent>(_handleDeleteHome);
  }

  void test() async {
    final result = await homeRepository.getAllHomes();
    result.fold(
      (failure) => print('Error while fetching homes.'),
      (homeStream) async {
        homeStream2 = homeStream.listen((homes) {
          currentHomes = homes;
        });
      },
    );
  }

  FutureOr<void> _handleCreateHome(
    CreateHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(CreateHomeFetching());

    final result = await homeRepository.createHome(event.home);
    result.fold(
      (failure) =>
          emit(const CreateHomeError(message: 'Error while creating home.')),
      (_) => emit(CreateHomeSuccess()),
    );
  }

  FutureOr<void> _handleGetAllHomes(
    GetAllHomesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(GetAllHomesFetching());

    if (currentHomes.isEmpty) {
      emit(const GetAllHomesError(message: 'No homes found. Create One!'));
      return;
    }

    emit(GetAllHomesSuccess(homes: currentHomes));
  }

  FutureOr<void> _handleUpdateHome(
    UpdateHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(UpdateHomeFetching());

    final result = await homeRepository.updateHome(event.home);
    result.fold(
      (failure) =>
          emit(const UpdateHomeError(message: 'Error while updating home.')),
      (_) => emit(UpdateHomeSuccess()),
    );
  }

  FutureOr<void> _handleDeleteHome(
    DeleteHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(DeleteHomeFetching());

    final result = await homeRepository.deleteHome(event.home);
    result.fold(
      (failure) =>
          emit(const DeleteHomeError(message: 'Error while deleting home.')),
      (_) => emit(DeleteHomeSuccess()),
    );
  }
}
