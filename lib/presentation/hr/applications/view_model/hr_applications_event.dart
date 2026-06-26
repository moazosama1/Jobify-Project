sealed class HrApplicationsEvent {
  const HrApplicationsEvent();
}

class LoadHrApplicationsEvent extends HrApplicationsEvent {
  const LoadHrApplicationsEvent();
}

class SearchHrApplicationsEvent extends HrApplicationsEvent {
  final String query;
  const SearchHrApplicationsEvent(this.query);
}
