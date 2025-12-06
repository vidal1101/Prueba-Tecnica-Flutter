
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/items_repository.dart';
import 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final ItemsRepository repository;

  ApiCubit(this.repository) : super(ApiInitial());

  Future<void> fetchApiItems() async {
    emit(ApiLoading());

    try {
      final items = await repository.fetchRemoteItems();
      emit(ApiLoaded(items));
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }
}
