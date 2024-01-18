import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/get_country_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/auth_provider.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final AuthProvider authProvider;
  CountryBloc({required this.authProvider}) : super(CountryInitial()) {
    on<GetCountryEvent>((event, emit) async{
      emit(CountryLoading());
      final StateModel? stateModel = await authProvider.getCountry();
      if(stateModel is SuccessState) {
        emit(CountryLoaded(countryResponse: stateModel.value));
      }
    });
  }
}
