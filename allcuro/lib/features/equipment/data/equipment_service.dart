import 'models/equipment.dart';

const _eqWheelchairImage = 'assets/images/eq-wheelchair.jpg';
const _eqOxygenImage = 'assets/images/eq-oxygen.jpg';
const _eqBedImage = 'assets/images/eq-bed.jpg';

/// Local data source for rentable equipment. Stands in for a future call
/// through [ApiClient] — the repository above it doesn't care whether the
/// list comes from here or from the network.
class EquipmentService {
  const EquipmentService();

  Future<List<Equipment>> fetchAll() async => _equipment;

  Future<List<String>> fetchCategories() async => _categories;
}

const List<String> _categories = [
  'Mobility',
  'Respiratory',
  'Hospital furniture',
  'Monitoring',
  'ICU-grade',
];

const List<Equipment> _equipment = [
  Equipment(
    id: 'wheelchair',
    name: 'Foldable wheelchair',
    category: 'Mobility',
    photo: _eqWheelchairImage,
    perDay: 120,
    perMonth: 1800,
    deposit: 2000,
    condition: 'Refurbished · Grade A',
    availableIn: '560076',
  ),
  Equipment(
    id: 'oxygen',
    name: 'Oxygen concentrator 5L',
    category: 'Respiratory',
    photo: _eqOxygenImage,
    perDay: 450,
    perMonth: 8500,
    deposit: 10000,
    condition: 'New',
    availableIn: '560076',
  ),
  Equipment(
    id: 'bed',
    name: 'Electric hospital bed',
    category: 'Hospital furniture',
    photo: _eqBedImage,
    perDay: 380,
    perMonth: 6900,
    deposit: 8000,
    condition: 'Refurbished · Grade A',
    availableIn: '560076',
  ),
];
