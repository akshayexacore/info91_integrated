import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/info-model.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';

class GroupInfpController extends GetxController {
  final _infromationRepository = InfromationRepository();
  final startController = Get.put(StarScreenController());
  var dataModel = InfoGroupDataModel().obs;
  @override
  void onInit() {
    getInfoData();
    // TODO: implement onInit
    super.onInit();
  }

  getInfoData() async {
    try {
      final response = await _infromationRepository
          .getInfoData(startController.selectedChatModel?.id ?? "");
      dataModel.value = response;
    } catch (e) {}
  }
}
