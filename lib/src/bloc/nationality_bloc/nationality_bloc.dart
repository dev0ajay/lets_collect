import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/get_Nationality_Response.dart';
import 'package:lets_collect/src/resources/api_providers/auth_provider.dart';

import '../../model/state_model.dart';

part 'nationality_event.dart';
part 'nationality_state.dart';

class NationalityBloc extends Bloc<NationalityEvent, NationalityState> {
  final AuthProvider authProvider;
  NationalityBloc({required this.authProvider}) : super(NationalityInitial()) {
    on<GetNationality>((event, emit) async{
     emit(NationalityLoading());
     final StateModel? stateModel = await authProvider.getNation();
     if(stateModel is SuccessState) {
       emit(NationalityLoaded(nationalityResponse: stateModel.value));
     }
    });
  }
}
