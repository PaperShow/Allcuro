import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/checkout_repository.dart';
import '../data/models/pricing_breakdown.dart';

const _basePrice = 2400;

class CheckoutViewModel extends AsyncNotifier<PricingBreakdown> {
  @override
  Future<PricingBreakdown> build() {
    return ref.watch(checkoutRepositoryProvider).calculateBreakdown(base: _basePrice);
  }
}

final checkoutViewModelProvider =
    AsyncNotifierProvider<CheckoutViewModel, PricingBreakdown>(CheckoutViewModel.new);
