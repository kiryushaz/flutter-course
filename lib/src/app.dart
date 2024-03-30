import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/menu/view/menu_screen.dart';
import 'theme/theme.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: coffeeAppTheme,
      title: 'Coffee Shop App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: "/",
      routes: {
        "/": (context) => Container(
              color: coffeeAppTheme.colorScheme.background,
              child: const SafeArea(child: MenuScreen()),
            )
      },
    );
  }
}
