// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:chuck_norris_io/features/random/domain/entities/random_entitie.dart';
import 'package:chuck_norris_io/features/random/domain/usecases/get_random.dart';
import 'package:equatable/equatable.dart';

part 'random_event.dart';
part 'random_state.dart';

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final GetRandomUseCase getRandomUseCase;

  RandomBloc({
    required this.getRandomUseCase,
  }) : super(InitGetRandomState()) {
    on<GetRandomEvent>((event, emit) async {
      await _getRandom(event: event, emit: emit);
    });
  }

  /// This method getRandom balance from the stream
  Future<void> _getRandom({
    required GetRandomEvent event,
    required Emitter<RandomState> emit,
  }) async {
    emit(LoadingState());

    final result = await getRandomUseCase(
      const ParamsUseCaseGetRandom(),
    );

    return result.fold(
      (l) {
        emit(FailedGetRandomState());
      },
      (resp) {
        emit(
          SuccessGetRandomState(randomEntity: resp.response),
        );
      },
    );
  }
}
