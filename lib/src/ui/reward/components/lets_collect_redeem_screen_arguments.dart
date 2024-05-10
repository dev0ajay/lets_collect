class LetCollectRedeemScreenArguments {
  final String requiredPoint;
  final String imageUrl;
  final String name;

  final List<String> wereToRedeem;
  final List<String> wereToRedeemAr;
  String? iD;
  String? from;
  int? rewardId;
  String? totalPoint;

  LetCollectRedeemScreenArguments(
      {required this.requiredPoint,
      required this.imageUrl,
      required this.wereToRedeem,
      required this.wereToRedeemAr,
      this.iD,
      required this.rewardId,
      this.totalPoint,
      required this.name,
    });
}
