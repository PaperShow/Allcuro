import 'package:flutter_test/flutter_test.dart';
import 'package:allcuro/features/services/data/services_catalog.dart';
import 'package:allcuro/features/services/data/models/service_category.dart';
import 'package:allcuro/features/nurses/data/nurses_service.dart';

void main() {
  group('ServicesCatalog & Nursing Degree Matching Tests', () {
    test('contains all essential home care categories from docx catalog', () {
      final services = ServicesCatalog.allServices;
      expect(services.length, greaterThanOrEqualTo(12));

      final quickCare = ServicesCatalog.getById('quick-care');
      expect(quickCare, isNotNull);
      expect(quickCare!.group, ServiceGroup.instant);

      final woundCare = ServicesCatalog.getById('wound-care');
      expect(woundCare, isNotNull);
      expect(woundCare!.requiredDegree, contains('GNM'));
      expect(woundCare.nurseDegreeFilters, contains('GNM'));
      expect(woundCare.procedures.length, greaterThanOrEqualTo(4));

      final icuCare = ServicesCatalog.getById('icu-critical-care');
      expect(icuCare, isNotNull);
      expect(icuCare!.requiredDegree, contains('Critical Care'));
      expect(icuCare.nurseDegreeFilters, contains('Critical Care Certified'));

      final physio = ServicesCatalog.getById('physiotherapy');
      expect(physio, isNotNull);
      expect(physio!.requiredDegree, contains('BPT'));

      final attendant = ServicesCatalog.getById('elderly-attendant');
      expect(attendant, isNotNull);
      expect(attendant!.requiredDegree, contains('GDA'));
    });

    test('NursesService contains nurses matching all qualification tiers', () async {
      const service = NursesService();
      final nurses = await service.fetchAll();

      expect(nurses.length, greaterThanOrEqualTo(6));

      // 1. B.Sc Nursing
      expect(nurses.any((n) => n.level.contains('B.Sc')), isTrue);
      // 2. Critical Care Certified
      expect(nurses.any((n) => n.level.contains('Critical Care')), isTrue);
      // 3. GNM Diploma
      expect(nurses.any((n) => n.level.contains('GNM')), isTrue);
      // 4. ANM Midwife
      expect(nurses.any((n) => n.level.contains('ANM')), isTrue);
      // 5. BPT Physiotherapist
      expect(nurses.any((n) => n.level.contains('BPT')), isTrue);
      // 6. Certified GDA Attendant
      expect(nurses.any((n) => n.level.contains('GDA')), isTrue);
    });
  });
}
