import 'models/profile.dart';
import 'models/profile_menu_row.dart';

/// Local data source for the signed-in member's profile. Stands in for a
/// future call through [ApiClient] — the repository above it doesn't care
/// whether this comes from here or from the network.
class ProfileService {
  const ProfileService();

  Future<Profile> fetchCurrent() async => _profile;
}

const _profile = Profile(
  name: 'Ananya Kulkarni',
  initials: 'AK',
  phone: '+91 98765 43210',
  email: 'ananya.k@email.com',
  verified: true,
  menuRows: [
    ProfileMenuRow(iconKey: 'location', label: 'Saved addresses', hint: '2 saved'),
    ProfileMenuRow(iconKey: 'badge', label: 'ID verification', hint: 'Unlocks live-in bookings'),
    ProfileMenuRow(iconKey: 'wallet', label: 'ALLCURO credits', hint: '₹500'),
    ProfileMenuRow(iconKey: 'gift', label: 'Refer a family', hint: 'Earn ₹500'),
    ProfileMenuRow(iconKey: 'support', label: 'Help & SOS', hint: '24/7'),
  ],
);
