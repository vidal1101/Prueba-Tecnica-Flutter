

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/preference_item.dart';
import '../../../domain/repositories/items_repository.dart';
import 'preference_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final ItemsRepository repository;

  PreferenceCubit(this.repository) : super(PreferenceInitial());

  Future<void> loadPrefs() async {
    emit(PreferenceLoading());

    try {
      final items = await repository.fetchLocalItems();
      emit(PreferenceLoaded(items));
    } catch (e) {
      emit(PreferenceError(e.toString()));
    }
  }

  Future<void> addPref(PreferenceItem item) async {
    await repository.saveLocalItem(item);
    await loadPrefs();
  }

  Future<void> updatePref(PreferenceItem item) async {
    await repository.updateLocalItem(item);
    await loadPrefs();
  }

  Future<void> deletePref(int id) async {
    await repository.deleteLocalItem(id);
    await loadPrefs();
  }
}
