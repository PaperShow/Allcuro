import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/bookings_repository.dart';
import '../data/models/booking.dart';

class BookingsViewModel extends AsyncNotifier<List<Booking>> {
  BookingsRepository get _repository => ref.read(bookingsRepositoryProvider);

  @override
  Future<List<Booking>> build() {
    return _repository.getAll();
  }

  Future<Booking> createBooking(Booking newBooking) async {
    final created = await _repository.createBooking(newBooking);
    ref.invalidateSelf();
    return created;
  }
}

final bookingsViewModelProvider =
    AsyncNotifierProvider<BookingsViewModel, List<Booking>>(BookingsViewModel.new);

final singleBookingProvider =
    FutureProvider.family<Booking?, String>((ref, id) async {
  return ref.watch(bookingsRepositoryProvider).getById(id);
});
