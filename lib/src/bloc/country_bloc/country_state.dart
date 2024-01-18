part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoading extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoaded extends CountryState {
  final CountryResponse countryResponse;
  const CountryLoaded({required this.countryResponse});
  @override
  List<Object> get props => [countryResponse];
}