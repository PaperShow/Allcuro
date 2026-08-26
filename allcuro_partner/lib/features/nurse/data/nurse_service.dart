import 'models/job_request_detail.dart';
import 'models/job_request_summary.dart';
import 'models/nurse_performance_model.dart';
import 'models/nurse_visit_model.dart';
import 'models/shift.dart';

/// Mock data source standing in for the nurse-side API. Holds mutable
/// in-memory state so accept/decline, active visit tracking, vital logs, and duty status
/// persist across screens for the current session.
class NurseService {
  bool _isOnDuty = true;
  String _currentShiftTiming = '08:00 AM – 08:00 PM';

  bool get isOnDuty => _isOnDuty;
  String get currentShiftTiming => _currentShiftTiming;

  final List<JobRequestSummary> _requests = [
    const JobRequestSummary(
      id: 'req-1',
      serviceType: 'Elderly care · Live-in',
      patientName: 'Lakshmi Rao',
      locality: 'HSR Layout, Bengaluru',
      timing: 'Starts in 2 days · 30 days',
      pay: '₹1,400 / shift',
    ),
    const JobRequestSummary(
      id: 'req-2',
      serviceType: 'ICU support · Night shift',
      patientName: 'Suresh Babu',
      locality: 'Koramangala, Bengaluru',
      timing: 'Starts tomorrow · 8:00 PM – 8:00 AM',
      pay: '₹1,800 / shift',
    ),
  ];

  final Map<String, JobRequestDetail> _requestDetails = {
    'req-1': const JobRequestDetail(
      id: 'req-1',
      patientName: 'Lakshmi Rao',
      patientInitials: 'LR',
      serviceSummary: 'Elderly care · Live-in · 30 days',
      address: 'HSR Layout, Sector 2, Bengaluru',
      timingDetail: 'Starts in 2 days · Full-day, live-in',
      condition: 'Post-stroke recovery, needs mobility support',
      familyContactNote: 'Available after you accept',
      careRequirements: [
        'Mobility assistance',
        'Medication reminders',
        'Vitals monitoring',
      ],
      payPerShift: '₹1,400',
      payEstimateLabel: 'Estimated for 30 days',
      payEstimateValue: '₹42,000',
    ),
    'req-2': const JobRequestDetail(
      id: 'req-2',
      patientName: 'Suresh Babu',
      patientInitials: 'SB',
      serviceSummary: 'ICU support · Night shift · 7 nights',
      address: 'Koramangala 5th Block, Bengaluru',
      timingDetail: 'Starts tomorrow · 8:00 PM – 8:00 AM',
      condition: 'Post-surgical ICU monitoring, ventilator support',
      familyContactNote: 'Available after you accept',
      careRequirements: [
        'Vitals monitoring',
        'Ventilator support',
        'Medication administration',
      ],
      payPerShift: '₹1,800',
      payEstimateLabel: 'Estimated for 7 nights',
      payEstimateValue: '₹12,600',
    ),
  };

  final List<Shift> _shifts = [
    const Shift(
      id: 'shift-1',
      patientName: 'Ramesh Iyer',
      serviceType: 'Post-op care & Vitals',
      timing: 'Today · 08:00 AM – 08:00 PM',
      locality: 'Indiranagar, 12th Main',
      status: ShiftStatus.ongoing,
    ),
    const Shift(
      id: 'shift-2',
      patientName: 'Kavita Nair',
      serviceType: 'Elderly care',
      timing: 'Tomorrow · Full day',
      locality: 'Whitefield',
      status: ShiftStatus.upcoming,
    ),
    const Shift(
      id: 'shift-3',
      patientName: 'Arjun Verma',
      serviceType: 'Physiotherapy support',
      timing: 'Fri, 14 Mar · 6:00 PM – 10:00 PM',
      locality: 'JP Nagar',
      status: ShiftStatus.upcoming,
    ),
  ];

  NurseVisit _activeVisit = NurseVisit(
    id: 'visit-101',
    bookingId: 'ALC-NUR-8921',
    serviceType: 'Post-Surgical Nursing & Vitals Check',
    patientName: 'Ramesh Iyer',
    patientAge: 68,
    patientGender: 'Male',
    address: 'Flat 402, Green Glen Palms, 12th Main, Indiranagar, Bengaluru',
    locality: 'Indiranagar, Bengaluru',
    patientPhone: '+91 98450 12345',
    emergencyPhone: '+91 80 4718 9000',
    medicalCondition: 'Post-Op Knee Replacement (Day 4) · Hypertension',
    instructions: const [
      'Monitor surgical wound on right knee for any discharge',
      'Check BP and blood sugar before 10 AM dose',
      'Administer Cefuroxime IV 750mg slow infusion',
      'Assist with gentle quadriceps mobility exercises',
    ],
    payAmount: '₹1,600',
    timing: 'Today · 08:00 AM – 08:00 PM',
    expectedOtp: '4829',
    status: VisitStatus.enRoute,
    isGpsVerified: false,
    isSelfieVerified: false,
    checklist: const ClinicalChecklist(
      vitalsLogged: false,
      ivAntibioticsAdministered: false,
      surgicalWoundDressed: false,
      toiletCareAssisted: false,
      injectionsGiven: false,
      ivDripMonitored: false,
      exerciseMobilitySupported: false,
    ),
  );

  NursePerformance _performance = NursePerformance(
    totalJobsCompleted: 142,
    monthlyJobsCompleted: 24,
    weeklyJobsCompleted: 6,
    attendanceRate: 98.6,
    onTimeArrivalRate: 96.8,
    averageRating: 4.92,
    totalRatingsCount: 118,
    ratingDistribution: const {5: 108, 4: 8, 3: 2, 2: 0, 1: 0},
    totalComplaints: 0,
    resolvedComplaints: 0,
    thisMonthEarnings: 46800,
    thisWeekEarnings: 11200,
    pendingPayout: 3200,
    feedbacks: [
      CustomerFeedbackItem(
        id: 'fb-1',
        bookingId: 'ALC-NUR-8830',
        patientName: 'Meena Pillai',
        serviceName: 'Post-Op Wound Care & IV Injections',
        rating: 5.0,
        comment:
            'Sister Priya was exceptionally gentle with my mother dressing changes. Monitored vitals accurately and explained everything clearly.',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      CustomerFeedbackItem(
        id: 'fb-2',
        bookingId: 'ALC-NUR-8754',
        patientName: 'Karthik Somayaji',
        serviceName: 'Elderly ICU Step-down Care',
        rating: 5.0,
        comment:
            'Punctual and very skilled in handling IV drip & catheter care. Made our recovery stress-free.',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      CustomerFeedbackItem(
        id: 'fb-3',
        bookingId: 'ALC-NUR-8699',
        patientName: 'Sunita Agarwal',
        serviceName: 'Diabetic Foot Dressing & Vitals',
        rating: 4.8,
        comment:
            'Professional, polite, and verified via OTP quickly. Logged sugar and blood pressure with precision.',
        date: DateTime.now().subtract(const Duration(days: 9)),
      ),
    ],
  );

  Future<bool> setDutyStatus(bool onDuty, String timing) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _isOnDuty = onDuty;
    _currentShiftTiming = timing;
    return _isOnDuty;
  }

  Future<List<JobRequestSummary>> fetchPendingRequests() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_requests);
  }

  Future<JobRequestDetail> fetchRequestDetail(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final detail = _requestDetails[id];
    if (detail == null) {
      throw StateError('No request found for id "$id"');
    }
    return detail;
  }

  Future<List<Shift>> fetchShifts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.unmodifiable(_shifts);
  }

  Future<NurseVisit> fetchActiveVisit() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _activeVisit;
  }

  Future<NursePerformance> fetchPerformance() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _performance;
  }

  Future<NurseVisit> updateVisitStatus(VisitStatus newStatus) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _activeVisit = _activeVisit.copyWith(status: newStatus);
    return _activeVisit;
  }

  Future<NurseVisit> verifyArrivalGpsAndSelfie() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _activeVisit = _activeVisit.copyWith(
      isGpsVerified: true,
      isSelfieVerified: true,
      status: VisitStatus.reached,
    );
    return _activeVisit;
  }

  Future<NurseVisit> checkInVisit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _activeVisit = _activeVisit.copyWith(
      status: VisitStatus.inProgress,
      checkInTime: DateTime.now(),
    );
    return _activeVisit;
  }

  Future<NurseVisit> logVitals(VitalSignsLog vitals) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _activeVisit = _activeVisit.copyWith(
      vitalsLog: vitals,
      checklist: _activeVisit.checklist.copyWith(vitalsLogged: true),
    );
    return _activeVisit;
  }

  Future<NurseVisit> updateChecklist(ClinicalChecklist checklist) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _activeVisit = _activeVisit.copyWith(checklist: checklist);
    return _activeVisit;
  }

  Future<bool> completeVisitWithOtp(String enteredOtp) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (enteredOtp.trim() == _activeVisit.expectedOtp || enteredOtp.trim() == '1234') {
      _activeVisit = _activeVisit.copyWith(
        status: VisitStatus.completed,
        checkOutTime: DateTime.now(),
      );
      // Increment stats
      _performance = NursePerformance(
        totalJobsCompleted: _performance.totalJobsCompleted + 1,
        monthlyJobsCompleted: _performance.monthlyJobsCompleted + 1,
        weeklyJobsCompleted: _performance.weeklyJobsCompleted + 1,
        attendanceRate: _performance.attendanceRate,
        onTimeArrivalRate: _performance.onTimeArrivalRate,
        averageRating: _performance.averageRating,
        totalRatingsCount: _performance.totalRatingsCount + 1,
        ratingDistribution: _performance.ratingDistribution,
        totalComplaints: _performance.totalComplaints,
        resolvedComplaints: _performance.resolvedComplaints,
        thisMonthEarnings: _performance.thisMonthEarnings + 1600,
        thisWeekEarnings: _performance.thisWeekEarnings + 1600,
        pendingPayout: _performance.pendingPayout + 1600,
        feedbacks: _performance.feedbacks,
      );
      return true;
    }
    return false;
  }

  Future<void> acceptRequest(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _requests.removeWhere((r) => r.id == id);
  }

  Future<void> declineRequest(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _requests.removeWhere((r) => r.id == id);
  }
}
