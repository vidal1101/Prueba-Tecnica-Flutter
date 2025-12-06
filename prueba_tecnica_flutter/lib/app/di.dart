import 'package:dio/dio.dart';
import 'package:prueba_tecnica_flutter/data/repositories/local_images_repository_impl.dart';

import 'package:prueba_tecnica_flutter/presentation/cubits/api/api_cubit.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/local_images/local_images_cubit.dart';
import 'package:prueba_tecnica_flutter/presentation/cubits/preferences/preference_cubit.dart';

import '../data/datasources/api_client.dart';
import '../data/datasources/local/local_db.dart';
import '../data/repositories/items_repository_impl.dart';

class DI {
  // ========== EXTERNAL ==========
  final Dio dio = Dio();

  // ========== DATA SOURCES ==========
  late final ApiClient apiClient;
  late final LocalDB localDB;

  // ========== REPOSITORIES ==========
  late final ItemsRepositoryImpl itemsRepository;
  late final LocalImagesRepositoryImpl localImagesRepository;

  // ========== CUBITS ==========
  late final ApiCubit apiCubit;
  late final PreferenceCubit preferenceCubit;
  late final LocalImagesCubit localImagesCubit;


  DI() {
    // HTTP client
    apiClient = ApiClient(dio);

    // Local DB
    localDB = LocalDB.instance;

    // Remote repository (Picsum API)
    itemsRepository = ItemsRepositoryImpl(apiClient: apiClient, db: localDB);

    // Local repository (SQLite storage)
    localImagesRepository = LocalImagesRepositoryImpl(localDB);

    // Cubits
    apiCubit = ApiCubit(itemsRepository);
    preferenceCubit = PreferenceCubit(itemsRepository);
    localImagesCubit = LocalImagesCubit(localImagesRepository);
  }
}

final di = DI();
