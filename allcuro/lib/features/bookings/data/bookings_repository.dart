import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bookings_service.dart';
import 'models/booking.dart';

class BookingsRepository {
  final BookingsService _service;

  const BookingsRepository(this._service);

  Future<List<Booking>> getAll() => _service.fetchAll();
  Future<Booking?> getById(String id) => _service.fetchById(id);
  Future<Booking> createBooking(Booking booking) => _service.addBooking(booking);
}

final bookingsServiceProvider = Provider<BookingsService>((ref) => BookingsService());

final bookingsRepositoryProvider = Provider<BookingsRepository>(
  (ref) => BookingsRepository(ref.watch(bookingsServiceProvider)),
);
