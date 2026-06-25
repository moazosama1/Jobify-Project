sealed class JobSeekerApplicationsEvents {}

class LoadMyApplicationsEvent extends JobSeekerApplicationsEvents {
  final String? status;
  LoadMyApplicationsEvent({this.status});
}

class ChangeApplicationsFilterEvent extends JobSeekerApplicationsEvents {
  final String? status; // null means 'All', 'pending', 'accepted', 'rejected'
  ChangeApplicationsFilterEvent({this.status});
}

class SearchMyApplicationsEvent extends JobSeekerApplicationsEvents {
  final String query;
  SearchMyApplicationsEvent({required this.query});
}
