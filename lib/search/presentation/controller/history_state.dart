// history_state.dart

import '../../domain/models/history_entry.dart';

abstract class HistoryState {
  const HistoryState();
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntry> history;

  HistoryLoaded(this.history);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
