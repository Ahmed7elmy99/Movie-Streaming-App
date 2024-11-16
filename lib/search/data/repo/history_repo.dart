// history_repository.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/models/history_entry.dart';
import '../../domain/repo/base_history_repo.dart';

class HistoryRepository implements BaseHistoryRepository {
  @override
  Future<List<HistoryEntry>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('history') ?? '[]';
    final List<dynamic> historyList = json.decode(historyJson);
    return historyList.map((entry) => HistoryEntry(
      query: entry['title'],
      timestamp: DateTime.parse(entry['timestamp']),
    )).toList();
  }

  @override
  Future<void> saveEntry(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHistory = await getHistory();
    currentHistory.add(entry);
    final historyJson = json.encode(currentHistory
        .map((e) => {
      'title': e.query,
      'timestamp': e.timestamp.toIso8601String(),
    }).toList());
    await prefs.setString('history', historyJson);
  }

  @override
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
  }

  @override
  Future<void> addHistoryEntry(String title) async {
    final newEntry = HistoryEntry(
      query: title,
      timestamp: DateTime.now(),
    );
    await saveEntry(newEntry); // Use the saveEntry method to add the new entry
  }
}
