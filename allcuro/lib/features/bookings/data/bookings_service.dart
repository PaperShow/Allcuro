import 'models/booking.dart';

class BookingsService {
  final List<Booking> _bookings = [
    const Booking(
      id: 'ALC-NUR-8921',
      type: BookingType.nurse,
      title: 'Priya Sharma (GNM) · Post-Op Care',
      when: 'Today · 08:00 AM – 08:00 PM',
      status: 'In Progress',
      amount: 1600,
      otp: '4829',
      liveStatus: BookingLiveStatus.inProgress,
      patientName: 'Ramesh Iyer',
      patientAge: 68,
      patientGender: 'Male',
      address: 'Flat 402, Green Glen Palms, 12th Main, Indiranagar, Bengaluru',
      locality: 'Indiranagar, Bengaluru',
      providerName: 'Priya Sharma',
      providerPhone: '+91 98450 12345',
      providerRating: 4.92,
      providerQualifications: 'GNM · 4 yrs exp · HPR Verified',
      vitalsSummary: 'BP: 120/80 mmHg · Sugar: 112 mg/dL · Pulse: 74 bpm · Temp: 98.4 °F',
      condition: 'Post-Op Knee Replacement Care & IV Infusion',
    ),
    const Booking(
      id: 'ALC-CTR-4920',
      type: BookingType.careCentre,
      title: 'Sanjeevani Elder Care · Deluxe Room',
      when: 'Check-in: Tomorrow, 10:00 AM · 30 Days',
      status: 'Confirmed',
      amount: 45000,
      otp: '7391',
      liveStatus: BookingLiveStatus.assigned,
      patientName: 'Kavita Nair',
      patientAge: 74,
      patientGender: 'Female',
      address: 'Sanjeevani Elder Care, 4th Cross, 100ft Road, Indiranagar, Bengaluru',
      locality: 'Indiranagar, Bengaluru',
      providerName: 'Sanjeevani Elder Care Home',
      providerPhone: '+91 80 4120 5500',
      providerRating: 4.88,
      providerQualifications: 'Field Audited · 1:3 Nurse Ratio · Fire & NABH NOC',
      roomType: 'Deluxe Private Room with Assisted Bath',
      formalities: [
        'Govt Photo ID (Aadhaar / Passport) of patient',
        'Hospital Discharge Summary & Doctor Prescription',
        'Digital Admission Pass & Check-In OTP (7391)',
        'Signed Care Agreement & Emergency Contact Consent',
      ],
    ),
    const Booking(
      id: 'ALC-EQP-83102',
      type: BookingType.equipment,
      title: 'Philips EverFlo 5L Oxygen Concentrator',
      when: 'Monthly Rental · 18 days left',
      status: 'Active',
      amount: 4500,
      otp: '2910',
      liveStatus: BookingLiveStatus.inProgress,
      patientName: 'Ramesh Iyer',
      address: 'Indiranagar, Bengaluru',
      locality: 'Indiranagar',
    ),
    const Booking(
      id: 'ALC-NUR-82554',
      type: BookingType.nurse,
      title: 'Ananya Deshmukh (B.Sc) · IV Infusion',
      when: '14 Aug 2026 · Completed',
      status: 'Completed',
      amount: 1200,
      otp: '1839',
      liveStatus: BookingLiveStatus.completed,
      patientName: 'Ramesh Iyer',
      address: 'Indiranagar, Bengaluru',
      locality: 'Indiranagar',
      vitalsSummary: 'BP: 124/82 mmHg · Pulse: 76 bpm · Normal Recovery',
    ),
  ];

  Future<List<Booking>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.unmodifiable(_bookings);
  }

  Future<Booking?> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _bookings.firstWhere((b) => b.id == id, orElse: () => _bookings.first);
  }

  Future<Booking> addBooking(Booking newBooking) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _bookings.insert(0, newBooking);
    return newBooking;
  }
}
