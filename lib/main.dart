import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
// Note: setPathUrlStrategy() can be used to remove the '#' from web URLs.
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy(); // Removes the '#' from the URL
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
