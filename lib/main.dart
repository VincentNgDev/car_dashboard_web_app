import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_car_dashboard/screens/home_sn.dart';

import 'providers/vehicle.pd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VehicleProvider()),
      ],
      child: MaterialApp(
        title: 'Rental Car',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}