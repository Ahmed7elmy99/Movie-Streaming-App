// base_history_repo.dart

import '../../domain/models/history_entry.dart';

abstract class BaseHistoryRepository {
  Future<List<HistoryEntry>> getHistory();
  Future<void> saveEntry(HistoryEntry entry);
  Future<void> clearHistory();
  Future<void> addHistoryEntry(String title); // Add this line
}
