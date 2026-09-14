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
  // 1. B.Sc Nursing (4-Year Degree)
  Nurse(
    id: 'priya-sharma',
    name: 'Priya Sharma',
    photo: _nurse1Image,
    allcuroId: 'AC-N-10428',
    level: 'B.Sc Nursing',
    experience: 6,
    city: 'Bengaluru',
    languages: ['English', 'Hindi', 'Kannada'],
    tags: ['Wound & Dressing', 'Injections & IV', 'Catheter Care', 'Diabetic Care', 'Post-Op'],
    rating: 4.9,
    reviews: 212,
    highlights: ['B.Sc Gold Medalist', 'Very punctual', 'Gentle with wound care'],
    shifts: [
      ShiftOption(label: 'Home Visit (1–2 hrs)', price: 600, available: true),
      ShiftOption(label: 'Day Shift (12 hrs)', price: 1600, available: true),
      ShiftOption(label: 'Night Shift (12 hrs)', price: 1800, available: true),
    ],
    employment: Employment.fullTime,
  ),

  // 2. Critical Care Certified GNM/B.Sc (ICU / Ventilator / Tracheostomy)
  Nurse(
    id: 'rahul-menon',
    name: 'Rahul Menon',
    photo: _nurse2Image,
    allcuroId: 'AC-N-10891',
    level: 'Critical Care Certified',
    experience: 9,
    city: 'Bengaluru',
    languages: ['English', 'Malayalam', 'Tamil', 'Hindi'],
    tags: ['Ventilator', 'Tracheostomy', 'ICU Stepdown', 'Palliative Care', 'Injections & IV'],
    rating: 4.95,
    reviews: 186,
    highlights: ['Ex-Manipal Hospital ICU', 'Handles emergencies calmly', 'Tracheostomy specialist'],
    shifts: [
      ShiftOption(label: '12-Hr ICU Day Shift', price: 2000, available: true),
      ShiftOption(label: '12-Hr ICU Night Shift', price: 2300, available: true),
      ShiftOption(label: '24-Hr Live-in ICU Care', price: 3400, available: true),
    ],
    employment: Employment.fullTime,
  ),

  // 3. GNM Diploma (General Nursing & Midwifery - Core Home Visit)
  Nurse(
    id: 'rajesh-kumar',
    name: 'Rajesh Kumar',
    photo: _nurse2Image,
    allcuroId: 'AC-N-10315',
    level: 'GNM Diploma',
    experience: 7,
    city: 'Bengaluru',
    languages: ['English', 'Hindi', 'Kannada', 'Telugu'],
    tags: ['Injections & IV', 'Wound Dressing', 'Catheter & Ryle\'s', 'Elderly Nursing'],
    rating: 4.85,
    reviews: 142,
    highlights: ['Expert in painless IV cannulation', 'Great bedside manner', 'Police verified'],
    shifts: [
      ShiftOption(label: 'Home Visit (1–2 hrs)', price: 500, available: true),
      ShiftOption(label: 'Day Shift (12 hrs)', price: 1400, available: true),
      ShiftOption(label: 'Night Shift (12 hrs)', price: 1600, available: true),
    ],
    employment: Employment.fullTime,
  ),

  // 4. ANM Diploma / Midwife (Auxiliary Nurse Midwife - Vitals & Maternal)
  Nurse(
    id: 'sunita-verma',
    name: 'Sunita Verma',
    photo: _nurse1Image,
    allcuroId: 'AC-N-10552',
    level: 'ANM Midwife',
    experience: 5,
    city: 'Bengaluru',
    languages: ['Hindi', 'English', 'Bengali'],
    tags: ['General Nursing', 'Vitals Check', 'Mother & Baby', 'Injections & IV'],
    rating: 4.88,
    reviews: 98,
    highlights: ['Certified Midwife', 'Excellent baby care skills', 'Patient listener'],
    shifts: [
      ShiftOption(label: 'General Visit (1–2 hrs)', price: 450, available: true),
      ShiftOption(label: 'Maternal Visit (2 hrs)', price: 650, available: true),
      ShiftOption(label: 'Day Shift (12 hrs)', price: 1200, available: true),
    ],
    employment: Employment.partTime,
  ),

  // 5. BPT Physiotherapist (Bachelor of Physiotherapy & Neuro Rehab)
  Nurse(
    id: 'ananya-sen',
    name: 'Dr. Ananya Sen (PT)',
    photo: _nurse1Image,
    allcuroId: 'AC-PT-20109',
    level: 'BPT Physiotherapist',
    experience: 8,
    city: 'Bengaluru',
    languages: ['English', 'Hindi', 'Kannada', 'Bengali'],
    tags: ['Physiotherapy', 'Post-Stroke Rehab', 'Orthopedic Rehab', 'Elderly Mobility'],
    rating: 4.92,
    reviews: 164,
    highlights: ['Neuro Rehab Specialist', 'Custom exercise regimen', 'Brings portable TENS/IFT'],
    shifts: [
      ShiftOption(label: 'General Rehab Session (45m)', price: 750, available: true),
      ShiftOption(label: 'Neuro / Post-Stroke Session (60m)', price: 1100, available: true),
    ],
    employment: Employment.fullTime,
  ),

  // 6. Certified GDA Attendant (General Duty Assistant / Caregiver)
  Nurse(
    id: 'ramesh-pal',
    name: 'Ramesh Pal',
    photo: _nurse2Image,
    allcuroId: 'AC-CG-30241',
    level: 'Certified GDA Attendant',
    experience: 4,
    city: 'Bengaluru',
    languages: ['Hindi', 'Kannada'],
    tags: ['Elderly Care', 'Bed Bath', 'Mobility Support', 'Feeding Assistance', 'Companionship'],
    rating: 4.79,
    reviews: 87,
    highlights: ['Certified by NSDC Healthcare', 'Very strong & supportive for transfers', 'Warm & polite'],
    shifts: [
      ShiftOption(label: '12-Hr Day Attendant Shift', price: 950, available: true),
      ShiftOption(label: '24-Hr Live-in Attendant Shift', price: 1900, available: true),
    ],
    employment: Employment.fullTime,
  ),
];
