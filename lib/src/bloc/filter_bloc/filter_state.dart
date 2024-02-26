part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}
class BrandLoading extends FilterState {
  @override
  List<Object> get props => [];
}

class BrandLoaded extends FilterState {
  final BrandAndCategoryFilterResponse brandAndCategoryFilterResponse;
  const BrandLoaded({required this.brandAndCategoryFilterResponse});
  @override
  List<Object> get props => [brandAndCategoryFilterResponse];
}


///Supermarket List State
class SupermarketFilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}
class SupermarketFilterLoading extends FilterState {
  @override
  List<Object> get props => [];
}

class SupermarketFilterLoaded extends FilterState {
  final SuperMarketListResponse superMarketListResponse;
  const SupermarketFilterLoaded({required this.superMarketListResponse});
  @override
  List<Object> get props => [SuperMarketListResponse];
}

