
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/items_repository.dart';
import 'api_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


/// ApiCubit
/// 
/// This class represents the state management for the API. It fetches the remote items and emits them as state.
class ApiCubit extends Cubit<ApiState> {
  final ItemsRepository repository;

  ApiCubit(this.repository) : super(ApiInitial());

  Future<void> fetchApiItems() async {
    emit(ApiLoading());

    //Verificar conectividad antes de llamar al API
    final connectivity = await Connectivity().checkConnectivity();

    // ignore: unrelated_type_equality_checks
    if (connectivity == ConnectivityResult.none) {
      emit(ApiNoConnection("No hay conexión a Internet"));
      return;
    }

    try {
      final items = await repository.fetchRemoteItems();
      emit(ApiLoaded(items));
    } catch (e) {
      emit(ApiError(e.toString()));
    }
  }
}
