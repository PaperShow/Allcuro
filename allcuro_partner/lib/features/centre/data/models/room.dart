import 'bed_slot.dart';

/// A room in the centre, with the beds inside it. Grouped by [ward] in
/// `RoomInventoryScreen`.
class Room {
  final String id;
  final String ward;
  final String roomNumber;
  final String ratePerDay;
  final List<BedSlot> beds;

  const Room({
    required this.id,
    required this.ward,
    required this.roomNumber,
    required this.ratePerDay,
    required this.beds,
  });
}
