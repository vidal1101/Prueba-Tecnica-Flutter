import '../datasources/api_client.dart';
import '../datasources/local/local_db.dart';
import '../../domain/entities/preference_item.dart';
import '../../domain/repositories/items_repository.dart';

/// ItemsRepositoryImpl
/// 
/// This class implements the ItemsRepository interface and provides methods
/// to interact with the API and the local database.
class ItemsRepositoryImpl extends ItemsRepository {
  final ApiClient apiClient;
  final LocalDB db;


  /// ItemsRepositoryImpl constructor.
  ItemsRepositoryImpl({
    required this.apiClient,
    required this.db,
  });

  // ----- API -----
  @override
  Future<List<dynamic>> fetchRemoteItems() async {
    return await apiClient.getItems();
  }

  // ----- LOCAL -----
  @override
  Future<List<PreferenceItem>> fetchLocalItems() async {
    final rows = await db.getAllPrefs();
    return rows.map((e) => PreferenceItem.fromMap(e)).toList();
  }

  @override
  Future<void> saveLocalItem(PreferenceItem item) async {
    await db.insertPref(item.toMap());
  }

  @override
  Future<void> updateLocalItem(PreferenceItem item) async {
    await db.updatePref(item.toMap());
  }

  @override
  Future<void> deleteLocalItem(int id) async {
    await db.deletePref(id);
  }
}
