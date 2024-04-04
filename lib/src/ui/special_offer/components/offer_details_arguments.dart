class OfferDetailsArguments {
  final String offerImgUrl;
  final String offerDetailText;
  final String offerDetailTextArabic;
  final String offerHeading;
  final String offerHeadingArabic;
  final String startDate;
  final String endDate;
  final List<String> storeList;

  OfferDetailsArguments( {
    required this.offerHeadingArabic,
    required this.offerHeading,
    required this.endDate,
    required this.offerDetailText,
    required this.offerDetailTextArabic,
    required this.offerImgUrl,
    required this.startDate,
    required this.storeList,
  });
}