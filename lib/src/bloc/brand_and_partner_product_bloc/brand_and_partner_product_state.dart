part of 'brand_and_partner_product_bloc.dart';

abstract class BrandAndPartnerProductState extends Equatable {
  const BrandAndPartnerProductState();
}

class BrandAndPartnerProductInitial extends BrandAndPartnerProductState {
  @override
  List<Object> get props => [];
}

class BrandAndPartnerProductLoading extends BrandAndPartnerProductState {
  @override
  List<Object> get props => [];
}

class BrandAndPartnerProductLoaded extends BrandAndPartnerProductState {
  final BrandAndPartnerProductRequestResponse brandAndPartnerProductRequestResponse;
  const BrandAndPartnerProductLoaded({required this.brandAndPartnerProductRequestResponse});
  @override
  List<Object> get props => [brandAndPartnerProductRequestResponse];
}

class BrandAndPartnerProductErrorState extends BrandAndPartnerProductState {
  final String errorMsg;
  const BrandAndPartnerProductErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}