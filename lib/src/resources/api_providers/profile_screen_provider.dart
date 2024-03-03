import 'package:lets_collect/src/model/cms/privacy_policies.dart';
import 'package:lets_collect/src/model/cms/terms_and_condition.dart';

import '../../model/profile/my_profile_screen_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class ProfileDataProvider {

  ///Terms and conditions
  Future<StateModel?> getTermsAndConditions() async {
    final response = await ObjectFactory().apiClient.getTermsAndConditions();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<TermsAndConditionResponse>.success(
          TermsAndConditionResponse.fromJson(response.data));
    } else {
      return null;
    }  }

  ///Privacy policies
  Future<StateModel?> getPrivacyPolicies() async {
    final response = await ObjectFactory().apiClient.getPrivacyPolicies();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<PrivacyPoliciesResponse>.success(
          PrivacyPoliciesResponse.fromJson(response.data));
    } else {
      return null;
    }
  }


  ///GetProfile
  Future<StateModel?> getProfileData() async {
    final response = await ObjectFactory().apiClient.getProfileData();
    print(response.toString());

    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<MyProfileScreenResponse>.success(
            MyProfileScreenResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }


}