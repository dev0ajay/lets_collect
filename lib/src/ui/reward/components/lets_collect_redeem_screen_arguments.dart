class LetCollectRedeemScreenArguments {
   String? requiredPoint;
   String? imageUrl;
   String? name;

   List<String>? wereToRedeem;
   List<String>? wereToRedeemAr;
  String? iD;
  String? from;
  int? rewardId;
  String? totalPoint;

  LetCollectRedeemScreenArguments({
    this.requiredPoint,
    this.imageUrl,
    this.wereToRedeem,
    this.wereToRedeemAr,
    this.iD,
    this.rewardId,
    this.totalPoint,
    required this.name,
  });
}
