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
        body:LayoutBuilder(
          builder:(context,size)=>Obx(()=>controller.userData.value!=null?GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 2
              ),
              itemCount: controller.dataList.length,
              itemBuilder: (context, ind) => singleContainer(getColor(controller.dataList[ind].status),
                  controller.dataList[ind].dayCount.toString(),controller.dataList[ind].status.stringValue,size)):const Center(
            child: Text("Fetching Relevant Data...",style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.bold
            ),),
          ),
          ),
        ));
  singleContainer(
          CustomColors tileColor, String dayText, String dayStatus,BoxConstraints size) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: size.maxHeight * .15,
              width: size.maxWidth * .30,
              decoration: BoxDecoration(
                  color: tileColor.getShadeColors, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      dayText,
                      style:  TextStyle(
                          fontWeight: FontWeight.bold, fontSize: size.maxWidth*.02),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    dayStatus,
                    style:  TextStyle(fontWeight: FontWeight.bold,fontSize: size.maxWidth*.01),
                  )
                ],
              ),
            ),
            Container(
              height: size.maxHeight * .01,
              width: size.maxWidth * .30,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: tileColor.getColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
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
