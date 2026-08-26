/// One incoming placement request a homecare centre can accept or decline
/// based on current bed availability.
class PlacementRequestSummary {
  final String id;
  final String careType;
  final String familyContact;
  final String preference;
  final String duration;

  const PlacementRequestSummary({
    required this.id,
    required this.careType,
    required this.familyContact,
    required this.preference,
    required this.duration,
  });
}
