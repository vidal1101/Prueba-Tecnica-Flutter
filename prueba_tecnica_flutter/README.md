# prueba_tecnica_flutter


## Getting Started

lib/
  app/
    app.dart
    di.dart
  core/
    widgets/
  data/
    datasources/
      api_client.dart
      local/
        local_db.dart         <-- ÚNICA BD (SQFLITE)
    repositories/
      items_repository_impl.dart
    models/
      api_item_model.dart
  domain/
    entities/
      preference_item.dart
    repositories/
      items_repository.dart
  presentation/
    routes/
      app_router.dart
    cubits/
      api_cubit.dart
      api_state.dart
      preference_cubit.dart
      preference_state.dart
    screens/
      splash/
      home/
      api/
      prefs/



