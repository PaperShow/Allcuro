/// One bed inside a [Room].
class BedSlot {
  final String id;
  final String label;
  final bool occupied;

  const BedSlot({required this.id, required this.label, required this.occupied});
}
