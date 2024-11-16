// history_event.dart

abstract class HistoryEvent {}

class LoadHistory extends HistoryEvent {}

class AddHistoryEntry extends HistoryEvent {
  final String title;

  AddHistoryEntry(this.title);
}

class ClearHistory extends HistoryEvent {}
