import 'package:flutter/foundation.dart';

enum VisitStatus {
  assigned,
  enRoute,
  reached,
  inProgress,
  completed,
}

@immutable
class VitalSignsLog {
  final String bloodPressure; // e.g. "120/80"
  final int pulse; // bpm
  final int bloodSugar; // mg/dL
  final double temperature; // °F
  final int? spO2; // %
  final DateTime loggedAt;

  const VitalSignsLog({
    required this.bloodPressure,
    required this.pulse,
    required this.bloodSugar,
    required this.temperature,
    this.spO2 = 98,
    required this.loggedAt,
  });

  VitalSignsLog copyWith({
    String? bloodPressure,
    int? pulse,
    int? bloodSugar,
    double? temperature,
    int? spO2,
    DateTime? loggedAt,
  }) {
    return VitalSignsLog(
      bloodPressure: bloodPressure ?? this.bloodPressure,
      pulse: pulse ?? this.pulse,
      bloodSugar: bloodSugar ?? this.bloodSugar,
      temperature: temperature ?? this.temperature,
      spO2: spO2 ?? this.spO2,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }
}

@immutable
class ClinicalChecklist {
  final bool vitalsLogged;
  final bool ivAntibioticsAdministered;
  final String? ivAntibioticsNotes;
  final bool surgicalWoundDressed;
  final String? surgicalWoundNotes;
  final bool toiletCareAssisted;
  final bool injectionsGiven;
  final bool ivDripMonitored;
  final bool exerciseMobilitySupported;

  const ClinicalChecklist({
    this.vitalsLogged = false,
    this.ivAntibioticsAdministered = false,
    this.ivAntibioticsNotes,
    this.surgicalWoundDressed = false,
    this.surgicalWoundNotes,
    this.toiletCareAssisted = false,
    this.injectionsGiven = false,
    this.ivDripMonitored = false,
    this.exerciseMobilitySupported = false,
  });

  ClinicalChecklist copyWith({
    bool? vitalsLogged,
    bool? ivAntibioticsAdministered,
    String? ivAntibioticsNotes,
    bool? surgicalWoundDressed,
    String? surgicalWoundNotes,
    bool? toiletCareAssisted,
    bool? injectionsGiven,
    bool? ivDripMonitored,
    bool? exerciseMobilitySupported,
  }) {
    return ClinicalChecklist(
      vitalsLogged: vitalsLogged ?? this.vitalsLogged,
      ivAntibioticsAdministered: ivAntibioticsAdministered ?? this.ivAntibioticsAdministered,
      ivAntibioticsNotes: ivAntibioticsNotes ?? this.ivAntibioticsNotes,
      surgicalWoundDressed: surgicalWoundDressed ?? this.surgicalWoundDressed,
      surgicalWoundNotes: surgicalWoundNotes ?? this.surgicalWoundNotes,
      toiletCareAssisted: toiletCareAssisted ?? this.toiletCareAssisted,
      injectionsGiven: injectionsGiven ?? this.injectionsGiven,
      ivDripMonitored: ivDripMonitored ?? this.ivDripMonitored,
      exerciseMobilitySupported: exerciseMobilitySupported ?? this.exerciseMobilitySupported,
    );
  }

  int get completedCount {
    int count = 0;
    if (vitalsLogged) count++;
    if (ivAntibioticsAdministered) count++;
    if (surgicalWoundDressed) count++;
    if (toiletCareAssisted) count++;
    if (injectionsGiven) count++;
    if (ivDripMonitored) count++;
    if (exerciseMobilitySupported) count++;
    return count;
  }

  int get totalCount => 7;
}

@immutable
class NurseVisit {
  final String id;
  final String bookingId;
  final String serviceType;
  final String patientName;
  final int patientAge;
  final String patientGender;
  final String address;
  final String locality;
  final String patientPhone;
  final String emergencyPhone;
  final String medicalCondition;
  final List<String> instructions;
  final String payAmount;
  final String timing;
  final String expectedOtp;
  final VisitStatus status;
  final bool isGpsVerified;
  final bool isSelfieVerified;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final VitalSignsLog? vitalsLog;
  final ClinicalChecklist checklist;
  final double? rating;
  final String? customerReview;

  const NurseVisit({
    required this.id,
    required this.bookingId,
    required this.serviceType,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.address,
    required this.locality,
    required this.patientPhone,
    this.emergencyPhone = '+91 80 4718 9000',
    required this.medicalCondition,
    this.instructions = const [],
    required this.payAmount,
    required this.timing,
    required this.expectedOtp,
    this.status = VisitStatus.assigned,
    this.isGpsVerified = false,
    this.isSelfieVerified = false,
    this.checkInTime,
    this.checkOutTime,
    this.vitalsLog,
    this.checklist = const ClinicalChecklist(),
    this.rating,
    this.customerReview,
  });

  NurseVisit copyWith({
    String? id,
    String? bookingId,
    String? serviceType,
    String? patientName,
    int? patientAge,
    String? patientGender,
    String? address,
    String? locality,
    String? patientPhone,
    String? emergencyPhone,
    String? medicalCondition,
    List<String>? instructions,
    String? payAmount,
    String? timing,
    String? expectedOtp,
    VisitStatus? status,
    bool? isGpsVerified,
    bool? isSelfieVerified,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    VitalSignsLog? vitalsLog,
    ClinicalChecklist? checklist,
    double? rating,
    String? customerReview,
  }) {
    return NurseVisit(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      serviceType: serviceType ?? this.serviceType,
      patientName: patientName ?? this.patientName,
      patientAge: patientAge ?? this.patientAge,
      patientGender: patientGender ?? this.patientGender,
      address: address ?? this.address,
      locality: locality ?? this.locality,
      patientPhone: patientPhone ?? this.patientPhone,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      medicalCondition: medicalCondition ?? this.medicalCondition,
      instructions: instructions ?? this.instructions,
      payAmount: payAmount ?? this.payAmount,
      timing: timing ?? this.timing,
      expectedOtp: expectedOtp ?? this.expectedOtp,
      status: status ?? this.status,
      isGpsVerified: isGpsVerified ?? this.isGpsVerified,
      isSelfieVerified: isSelfieVerified ?? this.isSelfieVerified,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      vitalsLog: vitalsLog ?? this.vitalsLog,
      checklist: checklist ?? this.checklist,
      rating: rating ?? this.rating,
      customerReview: customerReview ?? this.customerReview,
    );
  }
}
