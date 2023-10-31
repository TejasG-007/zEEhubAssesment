import 'package:flutter/material.dart';
import 'package:userworkanalysis/controller/universal_controller.dart';
import 'package:get/get.dart';
import 'package:userworkanalysis/utilities/day_enums.dart';

class DayName extends StatefulWidget {
  const DayName({super.key,required this.size});
  final BoxConstraints size;

  @override
  State<DayName> createState() => _DayNameState();
}

class _DayNameState extends State<DayName> {
  final controller = Get.find<UniversalController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 2
    ),
    itemCount: 7,
    itemBuilder: (context, ind) =>   Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 5),
    padding: const EdgeInsets.all(8.0),
    height: widget.size.maxHeight * .15,
    width: widget.size.maxWidth * .30,
        child: Text(ind.getDayText,style: TextStyle(fontSize: widget.size.maxWidth*.015,fontWeight: FontWeight.bold),)))
    );
  }
}
