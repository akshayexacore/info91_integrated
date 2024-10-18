import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/models/base_response.dart';
import 'package:info91/src/models/information_group.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/utils/api_base_helper.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class InfromationRepository {
final ApiBaseHelper _api=ApiBaseHelper();
late final _preferences = SharedPreferencesDataProvider();


Future<BaseResponse> createGroupFun(InformationGroupCreationModel model) async {
    final response =
        await _api.post(ApiConstants.creationInformationAPi, body: model.toJson(), headers: {});
    AppDialog.showToast((response['otp'] ?? '').toString());
    return BaseResponse.fromJson(response);
  }
}