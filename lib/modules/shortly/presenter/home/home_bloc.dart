import 'package:bloc/bloc.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/domain/usecases/shortly_usecase.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_event.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.usecase) : super(HomeStartState());
  final ShortLinkUseCase usecase;
  List<LinkEntity> _links = [];

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield HomeLoadingState();

    if (event is ShortEvent) {
      yield* _mapShortenToState(event);
    } else if (event is RetrieveLinksEvent) {
      yield* _mapRetrieveLinksToState(event);
    } else if (event is StartEvent) {
      yield* _mapStartToState(event);
    } else if (event is DeleteLinkEvent) {
      yield* _mapRemoveLinksToState(event);
    }
  }

  Stream<HomeState> _mapShortenToState(ShortEvent event) async* {
    final _result = await usecase(event.link);
    yield _result.fold((l) => HomeFailureState(l), (r) {
      _links.add(r);
      return HomeSuccessState(r);
    });
  }

  Stream<HomeState> _mapRetrieveLinksToState(RetrieveLinksEvent event) async* {
    yield HomeRetrieveLinksState(_links);
  }

  Stream<HomeState> _mapStartToState(StartEvent event) async* {
    yield HomeStartState();
  }

  Stream<HomeState> _mapRemoveLinksToState(DeleteLinkEvent event) async* {
    _links.removeWhere((element) => element.id == event.id);
    yield HomeDeleteLinkState(_links);
  }
}
