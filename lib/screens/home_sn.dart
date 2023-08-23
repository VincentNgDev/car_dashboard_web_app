import 'package:flutter/material.dart';

import 'car_sn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Function Section
  @override
  void initState() {
    super.initState();
  }



  /// Widget section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: 100,
                color: Colors.amber,
                child: Column(
                  children: [],
                ),
              ),
            ),
            SliverFillRemaining(
              child: CarScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
