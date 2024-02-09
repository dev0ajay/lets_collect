class OfferDetailsArguments {
  final String offerImgUrl;
  final String offerDetailText;
  final String offerHeading;
  final String startDate;
  final String endDate;
  final List<String> storeList;

  OfferDetailsArguments({
    required this.offerHeading,
    required this.endDate,
    required this.offerDetailText,
    required this.offerImgUrl,
    required this.startDate,
    required this.storeList,
  });
}
