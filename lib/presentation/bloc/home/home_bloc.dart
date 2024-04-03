import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<HomeEntity> currentHomes = [
    const HomeEntity(
      id: '1',
      name: 'Freundin',
      city: 'Gera',
      street: 'Test Street',
      streetNumber: '55a',
      postcode: '75683',
    ),
    const HomeEntity(
      id: '2',
      name: 'Elternhaus',
      city: 'Pößneck',
      street: 'Test Street',
      streetNumber: '63a',
      postcode: '07381',
    ),
    const HomeEntity(
      id: '3',
      name: 'Eigene Wohung',
      city: 'Jena',
      street: 'Coole Streeeeeeeeeeeeeeeeeeeeeeet',
      streetNumber: '99',
      postcode: '92379',
    ),
    const HomeEntity(
      id: '4',
      name: 'Anwesen in den Bergen',
      city: 'Berchtesgaden',
      street: 'An der Kuhglocke',
      streetNumber: '13c',
      postcode: '12345',
    ),
  ];

  HomeBloc() : super(HomeEmpty()) {
    on<CreateHomeEvent>(_handleCreateHome);
    on<GetAllHomesEvent>(_handleGetAllHomes);
    on<UpdateHomeEvent>(_handleUpdateHome);
    on<DeleteHomeEvent>(_handleDeleteHome);
  }

  void _handleCreateHome(
    CreateHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(CreateHomeFetching());

    // TODO: hier wird dann der Usecase, etc. aufgerufen
  }

  void _handleGetAllHomes(
    GetAllHomesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(GetAllHomesFetching());

    await Future.delayed(const Duration(seconds: 2));

    emit(GetAllHomesSuccess(homes: currentHomes));

    // TODO: hier wird dann der Usecase, etc. aufgerufen
  }

  void _handleUpdateHome(
    UpdateHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(UpdateHomeFetching());

    // TODO: hier wird dann der Usecase, etc. aufgerufen
  }

  void _handleDeleteHome(
    DeleteHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(DeleteHomeFetching());

    // TODO: hier wird dann der Usecase, etc. aufgerufen
  }
}
