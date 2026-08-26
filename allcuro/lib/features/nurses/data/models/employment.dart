enum Employment { fullTime, partTime, liveIn }

extension EmploymentLabel on Employment {
  String get label => switch (this) {
    Employment.fullTime => 'Full-time',
    Employment.partTime => 'Part-time',
    Employment.liveIn => 'Live-in',
  };
}
