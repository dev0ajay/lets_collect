part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable{
  const SearchState();
}

class SearchInitial extends SearchState {

  @override
  List<Object?> get props => [];
}

class SearchLoading extends SearchState{
  @override
  List<Object?> get props =>[];
}

class SearchLoaded extends SearchState{
  final SearchCategoryRequestResponse searchCategoryRequestResponse;
  const SearchLoaded({required this.searchCategoryRequestResponse});
  @override
  List<Object?> get props =>[];

}

///Brand search

class BrandInitial extends SearchState {
  @override
  List<Object?> get props => [];
}

class BrandLoading extends SearchState{
  @override
  List<Object?> get props => [];
}

class BrandLoaded extends SearchState{
  final SearchBrandRequestResponse searchBrandRequestResponse;
  const BrandLoaded ({required this.searchBrandRequestResponse}) ;
  @override
  List<Object?> get props => [];
}