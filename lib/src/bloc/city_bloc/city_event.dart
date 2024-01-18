part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
}


class GetCityEvent extends CityEvent {
  final GetCityRequest getCityRequest;
  const GetCityEvent({required this.getCityRequest});
  @override

  List<Object?> get props => [getCityRequest];

}
