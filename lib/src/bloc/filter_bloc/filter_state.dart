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

