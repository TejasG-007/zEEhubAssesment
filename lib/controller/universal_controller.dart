import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:userworkanalysis/model/user_data_model.dart';
import 'package:userworkanalysis/utilities/colors_enums.dart';
class UniversalController extends GetxController{

static const url = "https://script.googleusercontent.com/macros/echo?user_content_key=jdMDDpo88zGoNoTUglL7-DhcMfqU2Z6SYh4q-KpqgEYx2ekCjZGJfDOhurTZVhBkrft4z6IGHc5HuJ70EAv9KjKYAhruOHDrm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnF9S3X9Rceqe98YeO7psJuuvoqdviPP7VJsBuyZ27tx_DhSyS_AEcDNqGf61oGIadcstoeT5GzTjD_lJTaTJ53UtkyE-pgrEHg&lib=MErBa2h-c7npCjZ7OQU0z2cbdvwfOgOcF";

Rxn<UserData> userData = Rxn<UserData>();
RxInt totalWorkingHours = 0.obs;
RxDouble avgForProdMeter = 0.0.obs;
Rxn<CustomColors> meterColor = Rxn<CustomColors>(CustomColors.red);

RxList<Datum> dataList = [
  Datum(dayCount: 0, days: "Monday", status: Status.status, hourCount: 0),
  Datum(dayCount: 0, days: "Tuesday", status: Status.status, hourCount: 0),
  Datum(dayCount: 0, days: "Wednesday", status: Status.status, hourCount: 0),
  Datum(dayCount: 0, days: "Thursday", status: Status.status, hourCount: 0),
  Datum(dayCount: 0, days: "Friday", status: Status.status, hourCount: 0),
  Datum(dayCount: 0, days: "Saturday", status: Status.status, hourCount: 0),
  Datum(dayCount: 0, days: "Sunday", status: Status.status, hourCount: 0),
].obs;

@override
onInit()async{
  userData.value = await getData();
  super.onInit();
}

Future<UserData?> getData()async{
  try{
    Uri urlFromString = Uri.parse(url);
    final res = await http.get(urlFromString);
    if(res.statusCode==200){
      print("Fetched Successfully");//logging
      addData(userDataFromJson(res.body));
      return userDataFromJson(res.body);
    }
    return null;
  }catch(e){
    print("Error While Fetching the data $e");//logging
    return null;
  }
}

  void addData(UserData data){
  dataList.addAll(data.data);
  getTotalWorkingHours(data.data);
  }

  void getTotalWorkingHours(List<Datum> datum){
    for(Datum datum in datum){
      totalWorkingHours.value+=datum.hourCount;
    }
    getAvgForProductiveMeter(datum.length);
  }

  void getAvgForProductiveMeter(int len){
    avgForProdMeter.value = (totalWorkingHours/(len*9))*100;
    setColorForMeter();
  }

  void setColorForMeter() {
  if(avgForProdMeter.value<35){
    meterColor.value = CustomColors.red;
  }
  else if(avgForProdMeter.value>=35 && avgForProdMeter.value<=70){
    meterColor.value = CustomColors.yellow;
  }else{
    meterColor.value = CustomColors.green;
  }
  }






}