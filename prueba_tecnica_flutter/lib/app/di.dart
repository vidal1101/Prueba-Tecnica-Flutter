import 'package:dio/dio.dart';

import 'package:prueba_tecnica_flutter/presentation/cubits/api/api_cubit.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/preferences/preference_cubit.dart';

import '../data/datasources/api_client.dart';
import '../data/datasources/local/local_db.dart';
import '../data/repositories/items_repository_impl.dart';


class DI {
  final Dio dio = Dio();
  late final ApiClient apiClient;

  late final LocalDB localDB;

  late final ItemsRepositoryImpl itemsRepository;

  late final ApiCubit apiCubit;
  late final PreferenceCubit preferenceCubit;

  DI() {
    // API
    apiClient = ApiClient(dio);

    // SQLite
    localDB = LocalDB.instance;

    // Repository
    itemsRepository = ItemsRepositoryImpl(
      apiClient: apiClient,
      db: localDB,
    );

    // Cubits
    apiCubit = ApiCubit(itemsRepository);
    preferenceCubit = PreferenceCubit(itemsRepository);
  }
}

final di = DI();
