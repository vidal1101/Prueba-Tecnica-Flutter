import 'package:equatable/equatable.dart';

/// ApiState
///
/// Represents the different states of the API request lifecycle.
abstract class ApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final List<dynamic> items;

  ApiLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ApiError extends ApiState {
  final String message;

  ApiError(this.message);

  @override
  List<Object?> get props => [message];
}

class ApiNoConnection extends ApiState {
  final String message;

  ApiNoConnection(this.message);

  @override
  List<Object?> get props => [message];
}
