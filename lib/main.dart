import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userworkanalysis/controller/universal_controller.dart';
import 'package:userworkanalysis/views/calender_view.dart';
import 'package:userworkanalysis/views/productive_meter_view.dart';

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final controller = Get.put(UniversalController());

  @override
  Widget build(BuildContext context) => const GetMaterialApp(
        home: HomeView(),
      );
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Column(
          children: [
            Expanded(flex: 1, child: ProductivityMeter()),
            Expanded(flex: 4, child: CalenderView())
          ],
        ),
      );
}




