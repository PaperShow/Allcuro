enum StaffRoleType {
  gnmNurse,
  anmNurse,
  bscNursing,
  criticalCareNurse,
  careAttendant,
  physiotherapist,
}

class StaffMember {
  final String id;
  final String name;
  final StaffRoleType roleType;
  final String qualification;
  final int experienceYears;
  final String ratio; // e.g. '1:1', '1:2', '1:4'
  final double shiftRate;
  final bool isCertified;
  final bool certificateExpiring;

  const StaffMember({
    required this.id,
    required this.name,
    required this.roleType,
    required this.qualification,
    required this.experienceYears,
    this.ratio = '1:4',
    this.shiftRate = 1800.0,
    this.isCertified = true,
    this.certificateExpiring = false,
  });

  String get roleLabel {
    switch (roleType) {
      case StaffRoleType.gnmNurse:
        return 'GNM Staff Nurse';
      case StaffRoleType.anmNurse:
        return 'ANM Duty Nurse';
      case StaffRoleType.bscNursing:
        return 'B.Sc Senior Nurse';
      case StaffRoleType.criticalCareNurse:
        return 'Critical Care Specialist';
      case StaffRoleType.careAttendant:
        return 'Trained Care Attendant';
      case StaffRoleType.physiotherapist:
        return 'Physiotherapy Specialist';
    }
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  StaffMember copyWith({
    String? id,
    String? name,
    StaffRoleType? roleType,
    String? qualification,
    int? experienceYears,
    String? ratio,
    double? shiftRate,
    bool? isCertified,
    bool? certificateExpiring,
  }) {
    return StaffMember(
      id: id ?? this.id,
      name: name ?? this.name,
      roleType: roleType ?? this.roleType,
      qualification: qualification ?? this.qualification,
      experienceYears: experienceYears ?? this.experienceYears,
      ratio: ratio ?? this.ratio,
      shiftRate: shiftRate ?? this.shiftRate,
      isCertified: isCertified ?? this.isCertified,
      certificateExpiring: certificateExpiring ?? this.certificateExpiring,
    );
  }
}
