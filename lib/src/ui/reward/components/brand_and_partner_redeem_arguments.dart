class BrandAndPartnerRedeemArguments {
  final String productImageUrl;
  final String requiredPoints;
  final List<String> whereToRedeem;
  final String qrCodeGenerationUrl;
  final String from;

  BrandAndPartnerRedeemArguments({
    required this.requiredPoints,
    required this.productImageUrl,
    required this.qrCodeGenerationUrl,
    required this.whereToRedeem,
    required this.from,
  });
}
