import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/home/home_page_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/home_provider.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeDataProvider homeDataProvider;
  HomeBloc({required this.homeDataProvider}) : super(HomeInitial()) {
    on<GetHomeData>((event, emit) async{
      emit(HomeLoading());

      final StateModel? stateModel = await homeDataProvider.getHomeData();
      if(stateModel is SuccessState) {
        emit(HomeLoaded(homeResponse: stateModel.value));
      }
      }
    );
  }
}
