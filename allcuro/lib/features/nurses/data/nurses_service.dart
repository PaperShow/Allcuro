import 'models/nurse.dart';
import 'models/shift_option.dart';

const _nurse1Image = 'assets/images/nurse-1.jpg';
const _nurse2Image = 'assets/images/nurse-2.jpg';

/// Local data source for nurses. Stands in for a future call through
/// [ApiClient] — the repository above it doesn't care whether the list
/// comes from here or from the network.
class NursesService {
  const NursesService();

  Future<List<Nurse>> fetchAll() async => _nurses;
}

const List<Nurse> _nurses = [
  Nurse(
    id: 'priya-sharma',
    name: 'Priya Sharma',
    photo: _nurse1Image,
    allcuroId: 'AC-N-10428',
    level: 'B.Sc Nursing',
    experience: 6,
    city: 'Bengaluru',
    languages: ['English', 'Hindi', 'Kannada'],
    tags: ['Post-op', 'Elderly care', 'ICU support', 'Diabetic care'],
    rating: 4.9,
    reviews: 212,
    highlights: ['Very punctual', 'Gentle with patients', 'Clear communication'],
    shifts: [
      ShiftOption(label: 'Morning shift · 8am – 8pm', price: 1200, available: true),
      ShiftOption(label: 'Night shift · 8pm – 8am', price: 1500, available: true),
      ShiftOption(label: '24-hr live-in', price: 2600, available: false),
    ],
    employment: Employment.partTime,
  ),
  Nurse(
    id: 'rahul-menon',
    name: 'Rahul Menon',
    photo: _nurse2Image,
    allcuroId: 'AC-N-10891',
    level: 'Critical Care Certified',
    experience: 9,
    city: 'Bengaluru',
    languages: ['English', 'Malayalam', 'Tamil'],
    tags: ['Ventilator', 'Palliative', 'Dialysis assist', 'Wound care'],
    rating: 4.8,
    reviews: 156,
    highlights: ['Handles emergencies calmly', 'Very experienced'],
    shifts: [
      ShiftOption(label: 'Morning shift · 8am – 8pm', price: 1600, available: true),
      ShiftOption(label: 'Night shift · 8pm – 8am', price: 1900, available: true),
      ShiftOption(label: '24-hr live-in', price: 3200, available: true),
    ],
    employment: Employment.fullTime,
  ),
];
