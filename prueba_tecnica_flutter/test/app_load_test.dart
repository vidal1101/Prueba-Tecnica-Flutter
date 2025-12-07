
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/app/app.dart';
import 'package:prueba_tecnica_flutter/app/di.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Reiniciar DI si fuera necesario
    di.apiCubit.fetchApiItems();
  });

  testWidgets('La app carga correctamente y muestra el SplashScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // El Splash tiene un CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Avanzamos el tiempo para que pase la animación de splash
    await tester.pump(const Duration(seconds: 3));

    // Ahora debería cargar el HomeScreen
    expect(find.text("Menú principal"), findsOneWidget);
  });
}
