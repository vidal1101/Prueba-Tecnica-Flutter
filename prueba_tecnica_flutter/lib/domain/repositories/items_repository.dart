
import '../entities/preference_item.dart';

abstract class ItemsRepository {
  // API Remote
  Future<List<dynamic>> fetchRemoteItems();

  // Local SQLite
  Future<List<PreferenceItem>> fetchLocalItems();
  Future<void> saveLocalItem(PreferenceItem item);
  Future<void> updateLocalItem(PreferenceItem item);
  Future<void> deleteLocalItem(int id);
}
