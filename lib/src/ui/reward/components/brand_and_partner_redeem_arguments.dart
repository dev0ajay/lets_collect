class BrandAndPartnerRedeemArguments {
  final String productImageUrl;
  final String requiredPoints;
  final List<String> whereToRedeem;
  final String qrCodeGenerationUrl;
  final String from;
  final int rewardId;
  final String totalPoint;

  BrandAndPartnerRedeemArguments({
    required this.requiredPoints,
    required this.productImageUrl,
    required this.qrCodeGenerationUrl,
    required this.whereToRedeem,
    required this.from,
    required this.rewardId,
    required this.totalPoint,
  });
}
