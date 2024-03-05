import 'package:lets_collect/src/model/contact_us/contact_us_request.dart';
import 'package:lets_collect/src/model/contact_us/contact_us_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';

class ContactUsProvider {
  Future<StateModel?> contactUsRequest(ContactUsRequest contactUsRequest) async {
    final response = await ObjectFactory().apiClient.contactUsRequestClient(contactUsRequest);
    print(response.toString());
    if (response != null) {
      if (response.statusCode == 200) {
        return StateModel<ContactUsRequestResponse>.success(
            ContactUsRequestResponse.fromJson(response.data));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}