import 'package:equatable/equatable.dart';

class HistoryEntry extends Equatable {
  final String query; // The search query or title
  final DateTime timestamp; // The time when the entry was created

  HistoryEntry({
    required this.query,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [query, timestamp];

  @override
  String toString() {
    return 'HistoryEntry(query: $query, timestamp: $timestamp)';
  }
}
