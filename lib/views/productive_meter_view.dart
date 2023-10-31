import 'package:flutter/material.dart';
import 'dart:math';
import 'package:userworkanalysis/controller/universal_controller.dart';
import 'package:get/get.dart';
import 'package:userworkanalysis/utilities/colors_enums.dart';

class ProductivityMeter extends StatefulWidget {
  const ProductivityMeter({super.key});
  @override
  State<ProductivityMeter> createState() => _ProductivityMeterState();
}

class _ProductivityMeterState extends State<ProductivityMeter> {
  final controller = Get.find<UniversalController>();

  bool isMobileOrTab(BoxConstraints size) => size.maxWidth < 1300;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, size) => Container(
            height: size.maxHeight * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 20, color: Colors.grey, offset: Offset(5, 5))
                ]),
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: isMobileOrTab(size)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: allWidgets(size),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: allWidgets(size),
                  ),
          ),
        ),
      );

  iconAndTextCombo(IconData iconData, String text, Color color) {
    return Row(
      children: [
        Icon(iconData, color: color),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        )
      ],
    );
  }

  List<Widget> allWidgets(BoxConstraints size) => [
        SizedBox(
          width: size.maxHeight * .4,
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.bottomCenter,
            width: size.maxWidth * .4,
            child: Obx(
              () => CustomPaint(
                size: const Size(220, 220),
                painter: MeterUi(controller.meterColor.value!.getOffset),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Productivity Meter",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: isMobileOrTab(size)
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    iconAndTextCombo(Icons.circle, "Poor", Colors.red),
                    iconAndTextCombo(Icons.circle, "Average", Colors.yellow),
                    iconAndTextCombo(Icons.circle, "Good", Colors.green),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: isMobileOrTab(size) ? 1 : 2,
          child: Obx(
            () => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              margin: isMobileOrTab(size)
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(30),
              decoration: BoxDecoration(

                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                "Total Working hours: ${controller.totalWorkingHours.value}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ),
        )
      ];
}

class MeterUi extends CustomPainter {
  MeterUi(this.meterOffset);
  final Offset? meterOffset;
  final controller = Get.find<UniversalController>();
  @override
  void paint(Canvas canvas, Size size) {
    var rect = const Rect.fromLTRB(20, 20, 200, 220);
    const startAngle = pi;
    const sweepAngle = pi;
    const useCenter = false;
    var arcBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..color = Colors.red;
    var arcBrush2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..color = Colors.yellow;
    var arcBrush3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..color = Colors.green;
    var outerCircleBrush = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    var innerCircleBrush = Paint()..color = Colors.black;

    var lineBrush = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    //var lineEndOffset = controller.meterColor.value!.getOffset;
    canvas.drawArc(rect, startAngle, sweepAngle / 4, useCenter, arcBrush);
    canvas.drawArc(
        rect, 5 * startAngle / 4, sweepAngle / 4, useCenter, arcBrush2);
    canvas.drawArc(
        rect, 3 * startAngle / 2, sweepAngle / 2, useCenter, arcBrush3);
    canvas.drawLine(rect.center - const Offset(0, 10),
        meterOffset ?? const Offset(20, 109), lineBrush);
    canvas.drawCircle(rect.center - const Offset(0, 10), 9, innerCircleBrush);
    canvas.drawCircle(rect.center - const Offset(0, 10), 10, outerCircleBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
