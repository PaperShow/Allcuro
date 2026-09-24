import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/user_address.dart';

class LocationState {
  final UserAddress currentAddress;
  final List<UserAddress> savedAddresses;
  final bool isGpsDetecting;

  const LocationState({
    required this.currentAddress,
    required this.savedAddresses,
    this.isGpsDetecting = false,
  });

  LocationState copyWith({
    UserAddress? currentAddress,
    List<UserAddress>? savedAddresses,
    bool? isGpsDetecting,
  }) {
    return LocationState(
      currentAddress: currentAddress ?? this.currentAddress,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      isGpsDetecting: isGpsDetecting ?? this.isGpsDetecting,
    );
  }
}

const _initialAddresses = [
  UserAddress(
    id: 'addr-1',
    title: 'Home',
    addressLine: 'Flat 402, Green Glen Palms, 12th Main',
    locality: 'Indiranagar, Bengaluru',
    arrivalTime: '44 mins',
    tag: AddressTag.home,
    isDefault: true,
  ),
  UserAddress(
    id: 'addr-2',
    title: "Parents' Home",
    addressLine: 'Sanjeevani Villa, 4th Cross, 100ft Road',
    locality: 'Indiranagar, Bengaluru',
    arrivalTime: '38 mins',
    tag: AddressTag.parents,
  ),
  UserAddress(
    id: 'addr-3',
    title: 'Work / Office',
    addressLine: 'Prestige Tech Park, Outer Ring Road',
    locality: 'Marathahalli, Bengaluru',
    arrivalTime: '52 mins',
    tag: AddressTag.work,
  ),
  UserAddress(
    id: 'addr-4',
    title: 'South Delhi Home',
    addressLine: 'C-48, Greater Kailash 1',
    locality: 'South Delhi, New Delhi',
    arrivalTime: '45 mins',
    tag: AddressTag.other,
  ),
];

class LocationViewModel extends StateNotifier<LocationState> {
  LocationViewModel()
    : super(
        LocationState(
          currentAddress: _initialAddresses[0],
          savedAddresses: _initialAddresses,
        ),
      );

  void selectAddress(UserAddress address) {
    state = state.copyWith(currentAddress: address);
  }

  Future<void> useCurrentGpsLocation() async {
    state = state.copyWith(isGpsDetecting: true);
    await Future.delayed(const Duration(milliseconds: 700));
    final gpsAddress = UserAddress(
      id: 'gps-${DateTime.now().millisecondsSinceEpoch}',
      title: 'Current Location',
      addressLine: '12th Main Road, HAL 2nd Stage',
      locality: 'Indiranagar, Bengaluru',
      arrivalTime: '44 mins',
      tag: AddressTag.other,
    );

    // Keep unique
    final updatedList = [
      gpsAddress,
      ...state.savedAddresses.where((a) => a.id != gpsAddress.id),
    ];

    state = state.copyWith(
      currentAddress: gpsAddress,
      savedAddresses: updatedList,
      isGpsDetecting: false,
    );
  }

  void addNewAddress({
    required String houseNo,
    required String landmark,
    required String locality,
    required AddressTag tag,
  }) {
    final title = tag == AddressTag.home
        ? 'Home'
        : tag == AddressTag.work
        ? 'Work'
        : tag == AddressTag.parents
        ? "Parents' Home"
        : 'Other';

    final cleanLocality = locality.trim().isEmpty
        ? 'Indiranagar, Bengaluru'
        : locality.trim();
    final cleanAddressLine = landmark.trim().isEmpty
        ? houseNo.trim()
        : '${houseNo.trim()}, ${landmark.trim()}';

    final newAddr = UserAddress(
      id: 'addr-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      addressLine: cleanAddressLine,
      locality: cleanLocality,
      arrivalTime: '44 mins',
      tag: tag,
    );

    state = state.copyWith(
      currentAddress: newAddr,
      savedAddresses: [newAddr, ...state.savedAddresses],
    );
  }
}

final locationViewModelProvider =
    StateNotifierProvider<LocationViewModel, LocationState>((ref) {
      return LocationViewModel();
    });
