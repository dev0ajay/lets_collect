part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();
}

class CityInitial extends CityState {
  @override
  List<Object> get props => [];
}

class CityLoading extends CityState {
  @override
  List<Object> get props => [];
}

class CityLoaded extends CityState {
  final GetCityResponse getCityResponse;
  const CityLoaded({required this.getCityResponse});
  @override
  List<Object> get props => [];
}