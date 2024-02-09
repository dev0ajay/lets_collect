part of 'brand_and_partner_product_bloc.dart';

abstract class BrandAndPartnerProductEvent extends Equatable {
  const BrandAndPartnerProductEvent();
}


class GetBrandAndPartnerProductRequest extends BrandAndPartnerProductEvent {
  final BrandAndPartnerProductRequest brandAndPartnerProductRequest;
  const GetBrandAndPartnerProductRequest({required this.brandAndPartnerProductRequest});
  @override
  List<Object?> get props => [brandAndPartnerProductRequest];

}