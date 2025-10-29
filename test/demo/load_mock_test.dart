import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Load vehicle_info.json mock', () async {
    final jsonString = await rootBundle.loadString(
      'assets/mocks/vehicle_info.json',
    );
    print('JSON loaded: $jsonString');
  });
}
