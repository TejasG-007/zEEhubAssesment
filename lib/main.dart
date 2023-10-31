import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userworkanalysis/controller/universal_controller.dart';
import 'package:userworkanalysis/views/calender_view.dart';
import 'package:userworkanalysis/views/day_Name.dart';
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
  Widget build(BuildContext context) =>  Scaffold(
        body: LayoutBuilder(
          builder:(context,size) {
            return Column(
            children: [
              Expanded(flex: size.maxWidth>1300?1:4, child: const ProductivityMeter()),
               Expanded(child: DayName(size: size,)),
              const Expanded(flex: 4, child: CalenderView())
            ],
          );
          },
        ),
      );
}




