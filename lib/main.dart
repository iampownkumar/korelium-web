import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
// Note: setPathUrlStrategy() can be used to remove the '#' from web URLs.
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy(); // Removes the '#' from the URL
  
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
      appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
      projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID'],
    ),
  );
  
  runApp(const KoreliumPortfolioApp());
}

class KoreliumPortfolioApp extends StatelessWidget {

  const KoreliumPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Korelium | iampownkumar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
