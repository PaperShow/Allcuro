enum EquipmentCategory {
  respiratory,
  mobility,
  hospitalBeds,
  icuMonitoring,
  physiotherapy,
}

enum EquipmentCondition {
  brandNew,
  refurbishedGradeA,
  refurbishedGradeB,
}

class EquipmentItem {
  final String id;
  final String title;
  final EquipmentCategory category;
  final EquipmentCondition condition;
  final double dailyRate;
  final double monthlyRate;
  final double depositAmount;
  final int stockQuantity;
  final String specifications;
  final bool isAvailable;

  const EquipmentItem({
    required this.id,
    required this.title,
    required this.category,
    required this.condition,
    required this.dailyRate,
    required this.monthlyRate,
    required this.depositAmount,
    required this.stockQuantity,
    this.specifications = '',
    this.isAvailable = true,
  });

  String get categoryLabel {
    switch (category) {
      case EquipmentCategory.respiratory:
        return 'Respiratory Care';
      case EquipmentCategory.mobility:
        return 'Mobility & Ortho';
      case EquipmentCategory.hospitalBeds:
        return 'Hospital & ICU Beds';
      case EquipmentCategory.icuMonitoring:
        return 'ICU & Cardiac Monitoring';
      case EquipmentCategory.physiotherapy:
        return 'Physiotherapy & Rehab';
    }
  }

  String get conditionLabel {
    switch (condition) {
      case EquipmentCondition.brandNew:
        return 'Brand New';
      case EquipmentCondition.refurbishedGradeA:
        return 'Refurbished - Grade A';
      case EquipmentCondition.refurbishedGradeB:
        return 'Refurbished - Grade B';
    }
  }

  EquipmentItem copyWith({
    String? id,
    String? title,
    EquipmentCategory? category,
    EquipmentCondition? condition,
    double? dailyRate,
    double? monthlyRate,
    double? depositAmount,
    int? stockQuantity,
    String? specifications,
    bool? isAvailable,
  }) {
    return EquipmentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      dailyRate: dailyRate ?? this.dailyRate,
      monthlyRate: monthlyRate ?? this.monthlyRate,
      depositAmount: depositAmount ?? this.depositAmount,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      specifications: specifications ?? this.specifications,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}
