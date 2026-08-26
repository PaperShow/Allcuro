/// Full detail for a single shift request, opened from either the
/// dashboard preview or the requests list.
class JobRequestDetail {
  final String id;
  final String patientName;
  final String patientInitials;
  final String serviceSummary;
  final String address;
  final String timingDetail;
  final String condition;
  final String familyContactNote;
  final List<String> careRequirements;
  final String payPerShift;
  final String payEstimateLabel;
  final String payEstimateValue;

  const JobRequestDetail({
    required this.id,
    required this.patientName,
    required this.patientInitials,
    required this.serviceSummary,
    required this.address,
    required this.timingDetail,
    required this.condition,
    required this.familyContactNote,
    required this.careRequirements,
    required this.payPerShift,
    required this.payEstimateLabel,
    required this.payEstimateValue,
  });
}
