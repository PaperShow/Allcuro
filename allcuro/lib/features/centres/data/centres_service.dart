import 'models/centre.dart';
import 'models/score_item.dart';

const _centreImage = 'assets/images/centre-1.jpg';

/// Local data source for centres. Stands in for a future call through
/// [ApiClient] — the repository above it doesn't care whether the list
/// comes from here or from the network.
class CentresService {
  const CentresService();

  Future<List<Centre>> fetchAll() async => _centres;
}

const List<Centre> _centres = [
  Centre(
    id: 'serene-gardens',
    name: 'Serene Gardens Rehab',
    type: 'Rehab & recovery',
    locality: 'J.P. Nagar, 4th Phase',
    city: 'Bengaluru',
    photo: _centreImage,
    photoCount: 12,
    rating: 4.8,
    reviews: 128,
    since: 2018,
    licence: 'KA-HCS-2024/0981',
    staffRatio: '1 : 4',
    pricePerDay: 2400,
    pricePerMonth: 62000,
    bedsLeft: 2,
    services: [
      '24/7 Nursing',
      'Doctor on call',
      'Physiotherapy',
      'Diabetic meals',
      'Ambulance tie-up',
      'CCTV monitored',
    ],
    scores: [
      ScoreItem(label: 'Hygiene', value: 4.8),
      ScoreItem(label: 'Staff behaviour', value: 4.9),
      ScoreItem(label: 'Medical care', value: 4.7),
      ScoreItem(label: 'Food', value: 4.5),
      ScoreItem(label: 'Value for money', value: 4.6),
    ],
  ),
  Centre(
    id: 'silver-oaks',
    name: 'Silver Oaks Elder Home',
    type: 'Elderly care',
    locality: 'Hiranandani Gardens, Powai',
    city: 'Mumbai',
    photo: _centreImage,
    photoCount: 9,
    rating: 4.6,
    reviews: 84,
    since: 2014,
    licence: 'MH-CEA-2023/4402',
    staffRatio: '1 : 3',
    pricePerDay: 2900,
    pricePerMonth: 74000,
    bedsLeft: 5,
    services: [
      '24/7 Nursing',
      'Palliative care',
      'Family visiting hours',
      'Home-style meals',
      'CCTV monitored',
    ],
    scores: [
      ScoreItem(label: 'Hygiene', value: 4.7),
      ScoreItem(label: 'Staff behaviour', value: 4.6),
      ScoreItem(label: 'Medical care', value: 4.5),
      ScoreItem(label: 'Food', value: 4.8),
      ScoreItem(label: 'Value for money', value: 4.4),
    ],
  ),
  Centre(
    id: 'aarogya-daycare',
    name: 'Aarogya Physio & Day Care',
    type: 'Physiotherapy & day care',
    locality: 'Anna Nagar West',
    city: 'Chennai',
    photo: _centreImage,
    photoCount: 8,
    rating: 4.4,
    reviews: 51,
    since: 2020,
    licence: 'TN-CEA-2022/1177',
    staffRatio: '1 : 5',
    pricePerDay: 1400,
    pricePerMonth: 34000,
    bedsLeft: 8,
    services: ['Physiotherapy', 'Day care', 'Doctor on call', 'Meals'],
    scores: [
      ScoreItem(label: 'Hygiene', value: 4.5),
      ScoreItem(label: 'Staff behaviour', value: 4.4),
      ScoreItem(label: 'Medical care', value: 4.3),
      ScoreItem(label: 'Food', value: 4.1),
      ScoreItem(label: 'Value for money', value: 4.7),
    ],
  ),
];
