import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/cms/terms_and_condition.dart';

import '../../model/state_model.dart';
import '../../resources/api_providers/profile_provider.dart';

part 'terms_and_condition_event.dart';
part 'terms_and_condition_state.dart';

class TermsAndConditionBloc extends Bloc<TermsAndConditionEvent, TermsAndConditionState> {
  final ProfileDataProvider profileDataProvider;
  TermsAndConditionBloc({required this.profileDataProvider}) : super(TermsAndConditionInitial()) {
    on<GetTermsAndConditionEvent>((event, emit) async{
     emit(TermsAndConditionLoading());
     final StateModel? stateModel = await profileDataProvider.getTermsAndConditions();
     if(stateModel is SuccessState) {
       emit(TermsAndConditionLoaded(termsAndConditionResponse: stateModel.value));
     }
    });
  }
}
