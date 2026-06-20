sealed class SearchEvent {}

class LoadRecentSearchesEvent extends SearchEvent {}

class SearchQueryChangedEvent extends SearchEvent {
  final String query;
  SearchQueryChangedEvent(this.query);
}

class SearchSubmittedEvent extends SearchEvent {
  final String query;
  SearchSubmittedEvent(this.query);
}

class ClearRecentSearchesEvent extends SearchEvent {}
