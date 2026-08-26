import 'models/bed_slot.dart';
import 'models/placement_request_summary.dart';
import 'models/room.dart';

/// Mock data source standing in for the centre-side API. Holds mutable
/// in-memory state so accept/decline actually remove a request from the
/// list for the rest of the session. Swap this class for real HTTP calls
/// once there's a backend — `CentreRepository`'s surface can stay the same.
class CentreService {
  final List<PlacementRequestSummary> _requests = [
    const PlacementRequestSummary(
      id: 'plc-1',
      careType: 'Post-op recovery care',
      familyContact: 'Family of Deepak Shetty',
      preference: 'Prefers ground floor, single room',
      duration: '2 weeks · Starts in 3 days',
    ),
    const PlacementRequestSummary(
      id: 'plc-2',
      careType: 'Long-term elderly care',
      familyContact: 'Family of Radha Krishnan',
      preference: 'Shared room okay, needs wheelchair access',
      duration: 'Ongoing · Starts next week',
    ),
    const PlacementRequestSummary(
      id: 'plc-3',
      careType: 'Rehab & physiotherapy',
      familyContact: 'Family of Anitha George',
      preference: 'Prefers a centre with in-house physio',
      duration: '4 weeks · Starts today',
    ),
  ];

  final List<Room> _rooms = [
    const Room(
      id: 'room-101',
      ward: 'General Ward',
      roomNumber: 'Room 101',
      ratePerDay: '₹1,200 / day',
      beds: [
        BedSlot(id: 'room-101-a', label: 'Bed A', occupied: true),
        BedSlot(id: 'room-101-b', label: 'Bed B', occupied: true),
        BedSlot(id: 'room-101-c', label: 'Bed C', occupied: false),
        BedSlot(id: 'room-101-d', label: 'Bed D', occupied: false),
      ],
    ),
    const Room(
      id: 'room-102',
      ward: 'General Ward',
      roomNumber: 'Room 102',
      ratePerDay: '₹1,200 / day',
      beds: [
        BedSlot(id: 'room-102-a', label: 'Bed A', occupied: true),
        BedSlot(id: 'room-102-b', label: 'Bed B', occupied: true),
      ],
    ),
    const Room(
      id: 'room-201',
      ward: 'Private Rooms',
      roomNumber: 'Room 201',
      ratePerDay: '₹3,500 / day',
      beds: [BedSlot(id: 'room-201-a', label: 'Bed A', occupied: false)],
    ),
    const Room(
      id: 'room-202',
      ward: 'Private Rooms',
      roomNumber: 'Room 202',
      ratePerDay: '₹3,500 / day',
      beds: [BedSlot(id: 'room-202-a', label: 'Bed A', occupied: true)],
    ),
    const Room(
      id: 'room-301',
      ward: 'ICU',
      roomNumber: 'Room 301',
      ratePerDay: '₹6,000 / day',
      beds: [
        BedSlot(id: 'room-301-a', label: 'Bed A', occupied: true),
        BedSlot(id: 'room-301-b', label: 'Bed B', occupied: false),
      ],
    ),
  ];

  final int _admittedThisMonth = 7;

  Future<List<PlacementRequestSummary>> fetchPendingRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_requests);
  }

  Future<List<Room>> fetchRooms() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_rooms);
  }

  Future<int> fetchAdmittedThisMonth() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _admittedThisMonth;
  }

  Future<void> acceptRequest(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _requests.removeWhere((r) => r.id == id);
  }

  Future<void> declineRequest(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _requests.removeWhere((r) => r.id == id);
  }
}
