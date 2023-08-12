import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final Object? error;

  ServerFailure({
    this.error,
  });

  @override
  List<Object?> get props => [
        error,
      ];
}
