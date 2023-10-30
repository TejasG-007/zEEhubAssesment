import 'package:flutter/material.dart';
import 'package:userworkanalysis/controller/universal_controller.dart';
import 'package:userworkanalysis/model/user_data_model.dart';
import 'package:userworkanalysis/utilities/colors_enums.dart';
import 'package:userworkanalysis/utilities/day_enums.dart';
import 'package:get/get.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});
  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {

  final controller = Get.find<UniversalController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body:Obx(()=>controller.userData.value!=null?GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 0,
                crossAxisSpacing: 15,
                childAspectRatio: 1.3),
            itemCount: controller.dataList.length,
            itemBuilder: (context, ind) => controller.dataList[ind].dayCount==0
                ? Container(
              height: 10,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              child: Text(
                ind.getDayText,
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
              ),
            )
                : singleContainer(getColor(controller.dataList[ind].status),
                controller.dataList[ind].dayCount.toString(),controller.dataList[ind].status.stringValue)):const Center(
          child: Text("Fetching Relevant Data...",style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.bold
          ),),
        ),
        ));
  singleContainer(
          CustomColors tileColor, String dayText, String dayStatus) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .15,
              width: MediaQuery.sizeOf(context).width * .30,
              decoration: BoxDecoration(
                  color: tileColor.getShadeColors, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      dayText,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    dayStatus,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .14,
                  width: MediaQuery.sizeOf(context).width * .30,
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height * .01,
                  width: MediaQuery.sizeOf(context).width * .30,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: tileColor.getColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                )
              ],
            )
          ],
        ),
      );

  CustomColors getColor(Status name) {
    return switch(name.stringValue){
      "Present"=>CustomColors.green,
      "Absent"=>CustomColors.red,
      "Sick Leave"=>CustomColors.violet,
    _=>CustomColors.yellow
    };
  }
}
