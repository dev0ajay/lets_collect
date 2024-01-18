part of 'nationality_bloc.dart';

abstract class NationalityState extends Equatable {
  const NationalityState();
}

class NationalityInitial extends NationalityState {
  @override
  List<Object> get props => [];
}

class NationalityLoading extends NationalityState {
  @override
  List<Object> get props => [];
}

class NationalityLoaded extends NationalityState {
  final NationalityResponse nationalityResponse;
  const NationalityLoaded({required this.nationalityResponse});
  @override
  List<Object> get props => [
    nationalityResponse
  ];
}