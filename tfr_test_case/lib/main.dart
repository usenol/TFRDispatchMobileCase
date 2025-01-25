import 'package:flutter/material.dart';
import 'src/config/routes/app_router.dart';
import 'src/constants/route_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TFR Test Case',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: RouteConstants.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
