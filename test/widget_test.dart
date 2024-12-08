import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart'; // Import HydratedBloc for testing
import 'package:path_provider/path_provider.dart'; // Import path_provider for storage location
import 'package:pos_sales_app/main.dart'; // Import your main app

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Initialize HydratedStorage manually for testing
    final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

    // Build the app and trigger a frame with the mock storage
    // await tester.pumpWidget(MyApp(storage: storage));

    // Verify that the app starts correctly
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the counter has incremented
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
