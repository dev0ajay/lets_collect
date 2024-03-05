import 'package:lets_collect/src/model/redemption_history/redemption_history.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';

class RedemptionHistoryDataProvider {
  Future<StateModel?> getRedemptionData() async {
    final response = await ObjectFactory().apiClient.getRedemptionHistoryResponse();
    print(response.toString());

    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<RedemptionHistoryResponse>.success(
            RedemptionHistoryResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }

}