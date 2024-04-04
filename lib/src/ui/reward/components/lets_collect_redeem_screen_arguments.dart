class LetCollectRedeemScreenArguments {
  final String requiredPoint;
  final String imageUrl;
  final String brandName;
  final List<String> wereToRedeem;
  String? iD;
  String? from;
  int? rewardId;
  String? totalPoint;


  LetCollectRedeemScreenArguments({required this.requiredPoint,required this.imageUrl,required this.wereToRedeem, this.iD, required this.rewardId,this.totalPoint,required this.brandName});

}