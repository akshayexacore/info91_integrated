import 'package:get/get.dart';
import 'package:info91/src/resources/infromation_repository.dart';

class StarScreenController extends GetxController{
   final _infromationRepository = InfromationRepository();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


Future<void>joinMessageTapFunc()async{

try{
final response=await _infromationRepository.joinMessageTapFunc("1");
if(response.data1){

}else{
  
}
}catch(e){
  throw e;
}



}














}