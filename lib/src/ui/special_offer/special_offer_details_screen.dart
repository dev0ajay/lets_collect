import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/ui/special_offer/components/offer_details_arguments.dart';
import 'package:lottie/lottie.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpecialOfferScreenDetails extends StatefulWidget {
  final OfferDetailsArguments offerDetailsArguments;

  const SpecialOfferScreenDetails(
      {super.key, required this.offerDetailsArguments});

  @override
  State<SpecialOfferScreenDetails> createState() =>
      _SpecialOfferScreenDetailsState();
}

class _SpecialOfferScreenDetailsState extends State<SpecialOfferScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryWhiteColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryBlackColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.specialofferdetails,
          // "Special Offer Details",
          style: GoogleFonts.roboto(
            color: AppColors.primaryBlackColor,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.boxShadow,
                        blurRadius: 4,
                        offset: Offset(4, 2),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: widget.offerDetailsArguments.offerImgUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: const Duration(milliseconds: 200),
                      placeholder: (context, url) => SizedBox(
                        height: 40,
                        width: 40,
                        child: Lottie.asset(
                          Assets.JUMBINGDOT,
                        ),
                      ),
                      errorWidget: (context, url, error) => const ImageIcon(
                        color: AppColors.hintColor,
                        AssetImage(Assets.NO_IMG),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Flexible(
              flex: 3,
              child: Text(
                context.read<LanguageBloc>().state.selectedLanguage == Language.english
                    ? widget.offerDetailsArguments.offerHeading
                    :widget.offerDetailsArguments.offerHeadingArabic,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              // flex: 2,
              child: Text(
                context.read<LanguageBloc>().state.selectedLanguage == Language.english
                    ? widget.offerDetailsArguments.offerDetailText
                    : widget.offerDetailsArguments.offerHeadingArabic,
                style: const TextStyle(
                  color: AppColors.primaryColor2,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: RichText(
                softWrap: true,
                maxLines: 1,
                text: TextSpan(
                  text : AppLocalizations.of(context)!.startdate,
                  // text: 'Start Date: ',
                  style: const TextStyle(
                      color: AppColors.primaryColor2,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Fonarto"),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${widget.offerDetailsArguments.startDate}",
                      style: const TextStyle(
                          color: AppColors.secondaryButtonColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Fonarto"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: RichText(
                overflow: TextOverflow.clip,
                softWrap: true,
                maxLines: 1,
                text: TextSpan(
                  text: AppLocalizations.of(context)!.enddate,
                  // text: 'End Date: ',
                  style: const TextStyle(
                    color: AppColors.primaryColor2,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Fonarto",
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.offerDetailsArguments.endDate,
                      style: const TextStyle(
                        color: AppColors.secondaryButtonColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Fonarto",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            widget.offerDetailsArguments.storeList.isEmpty
                ? const SizedBox()
                : Flexible(
              // flex: 1,
              child: Text(
                "${AppLocalizations.of(context)!.findthisexclusiveofferat}",
                // "Find this exclusive offer at: ",
                style: GoogleFonts.openSans(
                  decoration: TextDecoration.underline,
                  color: AppColors.primaryColor2,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            widget.offerDetailsArguments.storeList.isEmpty
                ? const SizedBox()
                : Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    growable: true,
                    widget.offerDetailsArguments.storeList.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "\u2022 ${widget.offerDetailsArguments.storeList[index]}",
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryColor2,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}