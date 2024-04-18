
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/cms/privacy_policies.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

part 'privacy_policies_event.dart';
part 'privacy_policies_state.dart';

class PrivacyPoliciesBloc extends Bloc<PrivacyPoliciesEvent, PrivacyPoliciesState> {
  final ProfileDataProvider profileDataProvider;
  PrivacyPoliciesBloc({required this.profileDataProvider}) : super(PrivacyPoliciesInitial()) {
    on<GetPrivacyPolicies>((event, emit) async{
      emit(PrivacyPoliciesLaoding());
      final StateModel? stateModel = await profileDataProvider.getPrivacyPolicies();
      if(stateModel is SuccessState) {
        emit(PrivacyPoliciesLoaded(privacyPoliciesResponse: stateModel.value));
      }
      if(stateModel is ErrorState){
        emit(PrivacyPoliciesErrorState(errorMsg: stateModel.msg));
      }
    });
  }
}
