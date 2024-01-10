part of 'brand_bloc.dart';

@immutable
abstract class BrandState extends Equatable {
  const BrandState();
}

class BrandInitial extends BrandState {
  @override
  List<Object?> get props => [];
}

class BrandLoading extends BrandState{
  @override
  List<Object?> get props => [];
}

class BrandLoaded extends BrandState{
  final SearchBrandRequestResponse searchBrandRequestResponse;
  const BrandLoaded ({required this.searchBrandRequestResponse}) ;
  @override
  List<Object?> get props => [];
}