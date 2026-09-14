import 'package:flutter/material.dart';
import 'models/service_category.dart';

class ServicesCatalog {
  static const List<ServiceCategory> allServices = [
    // 1. Quick Care (Category Instant)
    ServiceCategory(
      id: 'quick-care',
      name: '⚡ Quick Nursing (< 45m)',
      shortName: '45m Quick Care',
      subtitle: 'Guaranteed nurse arrival within 45 mins',
      description: 'Emergency and urgent bedside nursing visits for vital monitoring, injections, nebulization, or urgent wound dressing.',
      group: ServiceGroup.instant,
      icon: Icons.bolt_rounded,
      iconColor: Color(0xFFE11D48),
      iconBgColor: Color(0xFFFEE2E2),
      requiredDegree: 'ANM / GNM / B.Sc Registered Nurse',
      priceRange: '₹450–750 / visit',
      marketPriceRange: '₹600–900 / visit',
      badge: '⚡ 45 MINS',
      procedures: [
        'Urgent vital signs monitoring (BP, SpO2, Pulse, Temp)',
        'Emergency IM/IV injection administration',
        'Urgent wound dressing & bandage replacement',
        'Nebulization & airway clearance support',
        'Immediate blood glucose & ketone check',
      ],
      nurseDegreeFilters: ['ANM', 'GNM', 'B.Sc Nursing', 'Critical Care Certified'],
    ),

    // 2. Wound & Dressing Care (Category A)
    ServiceCategory(
      id: 'wound-care',
      name: 'Post-Op Wound Dressing & Drain Care',
      shortName: 'Wound & Dressing',
      subtitle: 'Sterile surgical & chronic ulcer dressing',
      description: 'Clinical aseptic dressing for post-operative incisions, bed sores (pressure ulcers), surgical drain management, and suture removal.',
      group: ServiceGroup.clinical,
      icon: Icons.healing_rounded,
      iconColor: Color(0xFF0D9488),
      iconBgColor: Color(0xFFCCFBF1),
      requiredDegree: 'GNM / B.Sc Nursing',
      priceRange: '₹500–700 / visit',
      marketPriceRange: '₹600–900 / visit',
      badge: 'Aseptic Kit',
      procedures: [
        'Basic & surgical wound dressing',
        'Post-operative incision monitoring & care',
        'Diabetic foot ulcer dressing',
        'Pressure injury (bed sore) staging & dressing',
        'Suture / surgical staple removal',
        'Surgical drain emptying & measurement',
      ],
      nurseDegreeFilters: ['GNM', 'B.Sc Nursing', 'Critical Care Certified'],
    ),

    // 3. Injections & IV Cannulation (Category A)
    ServiceCategory(
      id: 'injections-iv',
      name: 'Injections & IV Cannula Administration',
      shortName: 'Injections & IV',
      subtitle: 'IM/IV, IV fluids & cannula insertion',
      description: 'Prescription-verified intravenous and intramuscular injections, saline/antibiotic IV drip set up, cannula changes, and insulin administration.',
      group: ServiceGroup.clinical,
      icon: Icons.vaccines_rounded,
      iconColor: Color(0xFF2563EB),
      iconBgColor: Color(0xFFDBEAFE),
      requiredDegree: 'GNM / B.Sc Nursing',
      priceRange: '₹400–600 / visit',
      marketPriceRange: '₹450–700 / visit',
      badge: 'Doctor Rx',
      procedures: [
        'IV cannulation & cannula site replacement',
        'IV fluid & antibiotic administration',
        'Intramuscular (IM) & Subcutaneous injections',
        'Insulin dosage administration & guidance',
        'Central line & PICC flush assistance',
      ],
      nurseDegreeFilters: ['GNM', 'B.Sc Nursing', 'Critical Care Certified'],
    ),

    // 4. Catheter & Ryle\'s Tube Care (Category A)
    ServiceCategory(
      id: 'catheter-tube',
      name: 'Catheter & Ryle\'s Tube Care',
      shortName: 'Catheter & Ryle\'s',
      subtitle: 'Foley change, NG tube insertion & feeding',
      description: 'Professional insertion, flushing, and replacement of urinary catheters (Foley) and nasogastric (Ryle\'s) feeding tubes.',
      group: ServiceGroup.clinical,
      icon: Icons.medication_liquid_rounded,
      iconColor: Color(0xFF7C3AED),
      iconBgColor: Color(0xFFEDE9FE),
      requiredDegree: 'GNM / B.Sc Nursing',
      priceRange: '₹500–700 / visit',
      marketPriceRange: '₹550–800 / visit',
      badge: 'High Skill',
      procedures: [
        'Foley catheter insertion & change',
        'Urinary drainage bag replacement & measurement',
        'Ryle\'s / NG tube insertion & positioning check',
        'NG tube feeding & flush protocols',
        'Colostomy bag care & hygiene',
      ],
      nurseDegreeFilters: ['GNM', 'B.Sc Nursing', 'Critical Care Certified'],
    ),

    // 5. ICU / Critical Care (12h/24h) (Category A)
    ServiceCategory(
      id: 'icu-critical-care',
      name: 'ICU / Critical Care / Ventilator Nursing',
      shortName: 'ICU & Ventilator',
      subtitle: '12h/24h ventilator & tracheostomy care',
      description: 'Intensive bedside care for post-ICU stepdown, tracheostomy suctioning, ventilator monitoring, and high-dependency patients.',
      group: ServiceGroup.clinical,
      icon: Icons.monitor_heart_rounded,
      iconColor: Color(0xFFDC2626),
      iconBgColor: Color(0xFFFEE2E2),
      requiredDegree: 'Critical Care Certified GNM / B.Sc',
      priceRange: '₹1,800–2,500 / shift (12h)',
      marketPriceRange: '₹2,000–3,000+ / shift',
      badge: '12h / 24h Shift',
      procedures: [
        'Ventilator mode monitoring & alarms management',
        'Tracheostomy care, dressing & deep suctioning',
        'Continuous vital signs & ABG tracking',
        'Post-ICU stroke & cardiac step-down nursing',
        'Infusion pump calibration & central line care',
      ],
      nurseDegreeFilters: ['Critical Care Certified', 'B.Sc Nursing'],
    ),

    // 6. Elderly Attendant (12h/24h) (Category B)
    ServiceCategory(
      id: 'elderly-attendant',
      name: 'Elderly Attendant & Caregiver (12h/24h)',
      shortName: 'Elderly Care',
      subtitle: 'Compassionate assistance & bed care',
      description: 'Dedicated GDA attendants for senior citizen assistance, bed baths, mobility support, feeding, incontinence care, and companionship.',
      group: ServiceGroup.support,
      icon: Icons.elderly_rounded,
      iconColor: Color(0xFFD97706),
      iconBgColor: Color(0xFFFEF3C7),
      requiredDegree: 'GDA / Trained Caregiver',
      priceRange: '₹900–1,400 / shift (12h)',
      marketPriceRange: '₹1,200–1,800 / shift',
      badge: 'Day / Live-in',
      procedures: [
        'Bed bath & sponge bath assistance',
        'Oral hygiene, grooming & clothing change',
        'Mobility, wheelchair transfer & ambulation',
        'Feeding assistance & fluid intake logging',
        'Incontinence care & pressure sore repositioning',
        'Medication reminders & daily companionship',
      ],
      nurseDegreeFilters: ['Certified GDA Attendant', 'ANM'],
    ),

    // 7. General Nursing Visit & Vitals (Category A)
    ServiceCategory(
      id: 'general-nursing',
      name: 'General Nursing Visit & Health Assessment',
      shortName: 'General Nursing',
      subtitle: 'Vitals, blood glucose & medication check',
      description: 'Comprehensive 1–2 hour nursing assessment visit including full vitals panel, diabetes monitoring, and routine medical check.',
      group: ServiceGroup.clinical,
      icon: Icons.health_and_safety_rounded,
      iconColor: Color(0xFF059669),
      iconBgColor: Color(0xFFD1FAE5),
      requiredDegree: 'ANM / GNM Diploma',
      priceRange: '₹450–600 / visit',
      marketPriceRange: '₹500–800 / visit',
      badge: '1–2 Hr Visit',
      procedures: [
        'Vital signs check: Blood Pressure, Pulse, SpO2, Temp',
        'Random / Fasting blood glucose monitoring',
        'General health & medication reconciliation',
        'Pain assessment & clinical observation report',
      ],
      nurseDegreeFilters: ['ANM', 'GNM', 'B.Sc Nursing'],
    ),

    // 8. Physiotherapy & Rehab (Category A)
    ServiceCategory(
      id: 'physiotherapy',
      name: 'Physiotherapy & Neuro / Post-Stroke Rehab',
      shortName: 'Physiotherapy',
      subtitle: 'Orthopedic, neuro & mobility recovery',
      description: 'Home sessions conducted by certified BPT physiotherapists for stroke rehabilitation, knee/hip replacement recovery, and elderly mobility.',
      group: ServiceGroup.clinical,
      icon: Icons.accessibility_new_rounded,
      iconColor: Color(0xFF4F46E5),
      iconBgColor: Color(0xFFE0E7FF),
      requiredDegree: 'BPT Physiotherapist',
      priceRange: '₹700–1,000 / session',
      marketPriceRange: '₹800–1,500 / session',
      badge: 'BPT Qualified',
      procedures: [
        'Post-operative joint & muscle rehabilitation',
        'Post-stroke neuro-muscular exercises',
        'Elderly gait & balance training',
        'Range-of-motion & chest physiotherapy',
        'Pain relief manual therapy & electrotherapy',
      ],
      nurseDegreeFilters: ['BPT Physiotherapist'],
    ),

    // 9. Maternal & Newborn Care (Category A)
    ServiceCategory(
      id: 'maternal-baby',
      name: 'Maternal & Newborn Care (Skilled Midwife)',
      shortName: 'Mother & Baby',
      subtitle: 'Postnatal care, baby bath & lactation',
      description: 'Specialized postnatal nursing support for mothers and newborns, including post-caesarean wound monitoring, baby vitals, and lactation guidance.',
      group: ServiceGroup.clinical,
      icon: Icons.child_care_rounded,
      iconColor: Color(0xFFDB2777),
      iconBgColor: Color(0xFFFCE7F3),
      requiredDegree: 'ANM / GNM (Midwifery)',
      priceRange: '₹600–900 / visit',
      marketPriceRange: '₹700–1,000 / visit',
      badge: 'Midwife Care',
      procedures: [
        'Postnatal maternal vitals & recovery check',
        'Post-caesarean incision / episiotomy care',
        'Newborn weight, jaundice & vitals monitoring',
        'Breastfeeding & latching support',
        'Newborn sterile bath & umbilical cord care',
      ],
      nurseDegreeFilters: ['ANM', 'GNM'],
    ),

    // 10. Home Care Centre Stays (Category C/Facility)
    ServiceCategory(
      id: 'care-centres',
      name: 'Home Care Centre Admissions & Respite Stays',
      shortName: 'Care Centres',
      subtitle: 'Audited elderly & rehabilitation facilities',
      description: 'Short-term and long-term admissions to audited home care centres with 24/7 nursing, doctor on-call, physiotherapy, and meal plans.',
      group: ServiceGroup.addon,
      icon: Icons.apartment_rounded,
      iconColor: Color(0xFF0284C7),
      iconBgColor: Color(0xFFE0F2FE),
      requiredDegree: 'Audited Healthcare Facility',
      priceRange: '₹1,400–2,900 / day',
      marketPriceRange: '₹1,800–3,500 / day',
      badge: 'Field Audited',
      procedures: [
        '24/7 round-the-clock nursing supervision',
        'Specialized dementia & stroke rehabilitation',
        'Doctor rounds & emergency hospital tie-up',
        'Dietitian-approved geriatric meals',
        'Physiotherapy & recreation daily sessions',
      ],
      nurseDegreeFilters: [],
    ),

    // 11. Medical Equipment Rental (Category C)
    ServiceCategory(
      id: 'equipment-rental',
      name: 'Medical Equipment Rental & Home Setup',
      shortName: 'Equipment',
      subtitle: 'Oxygen concentrators, ICU beds & wheelchairs',
      description: 'Hospital-grade sanitized medical equipment delivered and installed directly at your doorstep with technical support.',
      group: ServiceGroup.addon,
      icon: Icons.wheelchair_pickup_rounded,
      iconColor: Color(0xFF16A34A),
      iconBgColor: Color(0xFFDCFCE7),
      requiredDegree: 'Certified Equipment Partner',
      priceRange: '₹120–450 / day',
      marketPriceRange: 'Market-linked',
      badge: 'Sanitized Kit',
      procedures: [
        'Philips 5L/10L Oxygen concentrators',
        'Motorized 5-function ICU beds with air mattress',
        'Foldable lightweight wheelchairs & walkers',
        'BiPAP / CPAP respiratory setup & masks',
        'Suction machines & patient monitor rentals',
      ],
      nurseDegreeFilters: [],
    ),

    // 12. Doctor Home Visit & Teleconsult (Category C)
    ServiceCategory(
      id: 'doctor-visit',
      name: 'Doctor Home Visit & Teleconsultation',
      shortName: 'Doctor Visit',
      subtitle: 'Empanelled GP & geriatric specialists',
      description: 'At-home consultations by certified General Physicians and Geriatricians for health assessments, prescription refills, and medical guidance.',
      group: ServiceGroup.addon,
      icon: Icons.medical_services_rounded,
      iconColor: Color(0xFF9333EA),
      iconBgColor: Color(0xFFF3E8FF),
      requiredDegree: 'MBBS / MD Empanelled Doctor',
      priceRange: '₹700–1,000 / visit',
      marketPriceRange: '₹800–1,500 / visit',
      badge: 'MBBS / MD',
      procedures: [
        'Comprehensive at-home physical exam',
        'Digital prescription & medicine review',
        'Diagnostic lab test recommendations',
        'Hospital discharge care planning',
      ],
      nurseDegreeFilters: [],
    ),
  ];

  static ServiceCategory? getById(String id) {
    try {
      return allServices.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
