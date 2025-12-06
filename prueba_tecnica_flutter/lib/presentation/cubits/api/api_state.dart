
import 'package:equatable/equatable.dart';

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
