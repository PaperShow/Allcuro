enum AddressTag { home, work, parents, other }

class UserAddress {
  final String id;
  final String title;
  final String addressLine;
  final String locality;
  final String arrivalTime;
  final AddressTag tag;
  final bool isDefault;

  const UserAddress({
    required this.id,
    required this.title,
    required this.addressLine,
    required this.locality,
    this.arrivalTime = '44 mins',
    required this.tag,
    this.isDefault = false,
  });

  String get shortAddress {
    if (locality.isNotEmpty) {
      return locality;
    }
    return addressLine;
  }

  String get fullAddress => '$addressLine, $locality';

  UserAddress copyWith({
    String? id,
    String? title,
    String? addressLine,
    String? locality,
    String? arrivalTime,
    AddressTag? tag,
    bool? isDefault,
  }) {
    return UserAddress(
      id: id ?? this.id,
      title: title ?? this.title,
      addressLine: addressLine ?? this.addressLine,
      locality: locality ?? this.locality,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      tag: tag ?? this.tag,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
