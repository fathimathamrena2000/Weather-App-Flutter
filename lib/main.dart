import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/forecastapi.dart';
import 'package:weather_app/homepage.dart';
import 'package:weather_app/weatherapi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherDetails>(
            create: (context) => WeatherDetails()),
        ChangeNotifierProvider<ForecastDetails>(
            create: (context) => ForecastDetails()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
