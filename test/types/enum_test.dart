import 'package:flutter_test/flutter_test.dart';

import '../../packages/core/constants/constants.dart';

void main() {
  group("test enum", () {
    test("test enum stirng", () {
      const unknown = "unknown";
      const win = "win";

      expect(PlatformDesc.fromValue(unknown), equals(PlatformDesc.unknown));
      expect(PlatformDesc.fromValue(win), equals(PlatformDesc.win));
    });
  });
}
