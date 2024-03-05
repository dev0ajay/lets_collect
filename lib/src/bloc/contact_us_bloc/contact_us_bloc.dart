import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/contact_us/contact_us_request.dart';
import 'package:lets_collect/src/model/contact_us/contact_us_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/contact_us_provider.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final ContactUsProvider contactUsProvider;
  ContactUsBloc({required this.contactUsProvider}) : super(ContactUsInitial()) {
    on<GetContactUsEvent>((event, emit) async{
      emit(ContactUsLoading());
      final StateModel? stateModel =  await contactUsProvider.contactUsRequest(event.contactUsRequest);
      if(stateModel is SuccessState) {
        emit(ContactUsLoaded(contactUsRequestResponse: stateModel.value));
      }
    });
  }
}
