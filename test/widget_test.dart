// Smoke test: builds the app and checks that the two navigation tabs render.
// The default test locale is English, so the localized labels are checked.
//
// sqflite_common_ffi is used so the History screen (which opens the SQLite DB)
// does not require a real device platform channel.

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:voxtotext/main.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('App build smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const VoxToTextApp());
    await tester.pump();

    expect(find.text('Transcribe'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
  });
}
