enum ShiftStatus { upcoming, ongoing, completed }

/// A confirmed booking on the nurse's schedule.
class Shift {
  final String id;
  final String patientName;
  final String serviceType;
  final String timing;
  final String locality;
  final ShiftStatus status;

  const Shift({
    required this.id,
    required this.patientName,
    required this.serviceType,
    required this.timing,
    required this.locality,
    required this.status,
  });
}
