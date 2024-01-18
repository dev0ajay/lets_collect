part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable{
  const SearchEvent();
}

class GetSearchEvent extends SearchEvent{
  final SearchCategoryRequest searchCategoryRequest;
  const GetSearchEvent({required this.searchCategoryRequest});
  @override
  List<Object?> get props => [];

}

class GetBrandEvent extends SearchEvent {
  final SearchBrandRequest searchBrandRequest;
  const GetBrandEvent({required this.searchBrandRequest});
  @override
  List<Object?> get props => throw UnimplementedError();

}