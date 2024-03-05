import 'package:lets_collect/src/model/cms/privacy_policies.dart';
import 'package:lets_collect/src/model/cms/terms_and_condition.dart';
import 'package:lets_collect/src/model/edit_profile/edit_profile_request.dart';
import 'package:lets_collect/src/model/edit_profile/edit_profile_request_response.dart';
import 'package:lets_collect/src/model/my_profile/my_profile_screen_response.dart';

import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class MyProfileDataProvider {



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

  ///EditProfile
  Future<StateModel?> getEditProfileData(EditProfileRequest editProfileRequest) async {
    final response = await ObjectFactory().apiClient.getEditProfileData(editProfileRequest);
    print(response.toString());

    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<EditProfileRequestResponse>.success(
            EditProfileRequestResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }

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

}