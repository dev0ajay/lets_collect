part of 'brand_bloc.dart';

@immutable
abstract class BrandEvent extends Equatable {
  const BrandEvent();
}

class GetBrandEvent extends BrandEvent {
  final SearchBrandRequest searchBrandRequest;
  const GetBrandEvent({required this.searchBrandRequest});
  @override
  List<Object?> get props => throw UnimplementedError();

}