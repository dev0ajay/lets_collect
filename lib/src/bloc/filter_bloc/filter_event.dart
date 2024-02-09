part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}


class GetBrandAndCategoryFilterList extends FilterEvent {
  @override
  List<Object?> get props => [];

}
