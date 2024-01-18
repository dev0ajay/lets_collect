import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/model/auth/get_city_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../resources/api_providers/auth_provider.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  AuthProvider authProvider;
  CityBloc({required this.authProvider}) : super(CityInitial()) {
    on<GetCityEvent>((event, emit) async{
      emit(CityLoading());

      final StateModel? stateModel = await authProvider.getCity(event.getCityRequest);
      if(stateModel is SuccessState) {
        emit(CityLoaded(getCityResponse: stateModel.value));
      }
    });
  }
}
