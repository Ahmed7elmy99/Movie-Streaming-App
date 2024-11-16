// history_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/history_entry.dart';
import '../../domain/repo/base_history_repo.dart';
import 'history_events.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BaseHistoryRepository historyRepository;

  HistoryBloc(this.historyRepository) : super(HistoryLoading()) {
    on<LoadHistory>((event, emit) async {
      emit(HistoryLoading()); // Emit loading state
      try {
        final history = await historyRepository.getHistory();
        emit(HistoryLoaded(history)); // Emit loaded state with history
      } catch (e) {
        emit(HistoryError(e.toString())); // Emit error state on failure
      }
    });

    on<AddHistoryEntry>((event, emit) async {
      try {
        // Add the new entry to the repository
        await historyRepository.saveEntry(HistoryEntry(
          query: event.title,
          timestamp: DateTime.now(),
        ));
        // Load history again after adding the entry
        final history = await historyRepository.getHistory();
        emit(HistoryLoaded(history)); // Emit the updated history
      } catch (e) {
        emit(HistoryError(e.toString())); // Emit error state on failure
      }
    });

    on<ClearHistory>((event, emit) async {
      try {
        await historyRepository.clearHistory();
        emit(HistoryLoaded([])); // Emit an empty list after clearing
      } catch (e) {
        emit(HistoryError(e.toString())); // Emit error state on failure
      }
    });
  }
}
