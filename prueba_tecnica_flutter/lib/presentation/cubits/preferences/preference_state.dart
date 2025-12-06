
import 'package:equatable/equatable.dart';
import '../../../domain/entities/preference_item.dart';

abstract class PreferenceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceLoaded extends PreferenceState {
  final List<PreferenceItem> items;

  PreferenceLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class PreferenceError extends PreferenceState {
  final String message;

  PreferenceError(this.message);

  @override
  List<Object?> get props => [message];
}
