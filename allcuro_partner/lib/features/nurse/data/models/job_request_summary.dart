/// One incoming shift request, as shown in a list (dashboard preview or
/// the full requests list). See [JobRequestDetail] for the full-screen
/// version opened when a nurse taps in.
class JobRequestSummary {
  final String id;
  final String serviceType;
  final String patientName;
  final String locality;
  final String timing;
  final String pay;

  const JobRequestSummary({
    required this.id,
    required this.serviceType,
    required this.patientName,
    required this.locality,
    required this.timing,
    required this.pay,
  });
}
