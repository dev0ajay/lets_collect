import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/ui/notification/components/notification_details_argument.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/notification/notification_bloc.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/network_connectivity/bloc/network_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationBloc>(context).add(GetNotificationList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          // "Notification Center",
          AppLocalizations.of(context)!.notificationcenter,
          style: GoogleFonts.openSans(
            color: AppColors.primaryWhiteColor,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.primaryWhiteColor),
      ),
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is NetworkInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    // "You are not connected to the internet",
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkSuccess) {
            return SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.primaryWhiteColor,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SvgPicture.asset(
                        Assets.NOTIFICATION_SVG,
                        fit: BoxFit.contain,
                      ).animate().scale().then().shake(
                            duration: const Duration(milliseconds: 800),
                          ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    sliver: SliverToBoxAdapter(
                      child: BlocConsumer<NotificationBloc, NotificationState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is NotificationLoading) {
                            return const Center(
                              child: RefreshProgressIndicator(
                                color: AppColors.secondaryColor,
                                backgroundColor: AppColors.primaryWhiteColor,
                              ),
                            );
                          }
                          if (state is NotificationLoaded) {
                            if (state
                                .notificationGetResponse.data!.isNotEmpty) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                    state.notificationGetResponse.data!.length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        context.push(
                                          '/notification_details',
                                          extra: NotificationDetailsArgument(
                                              title: state.notificationGetResponse.data![index].notificationTitle!,
                                              message: state.notificationGetResponse.data![index].notificationMessage!,
                                              date: state.notificationGetResponse.data![index].addedDate!,
                                          ),
                                        );
                                      },
                                      child: IntrinsicHeight(
                                        child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 10,
                                              top: 8,
                                              bottom: 0),
                                          // height: 90,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(4, 2),
                                                spreadRadius: 0,
                                              ),
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(-4, -2),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      // flex: 2,
                                                      child: Text(
                                                        state
                                                            .notificationGetResponse
                                                            .data![index]
                                                            .notificationTitle!,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 17,
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    // Spacer(flex: 1,),

                                                    Flexible(
                                                      // flex: 2,
                                                      child: Text(
                                                        state
                                                            .notificationGetResponse
                                                            .data![index]
                                                            .notificationMessage!,
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 4,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 14,
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(flex: 1),
                                                    Flexible(
                                                      // flex: 1,
                                                      child: Text(
                                                        state
                                                            .notificationGetResponse
                                                            .data![index]
                                                            .addedDate!,
                                                        textAlign:
                                                            TextAlign.start,
                                                        maxLines: 1,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.zero,
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 18,
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ).animate().slideY());
                            } else {
                              return Center(
                                child: Lottie.asset(Assets.OOPS),
                              );
                            }
                          }
                          if (state is NotificationErrorState) {
                            return Center(
                              child: Column(
                                children: [
                                  Lottie.asset(Assets.TRY_AGAIN),
                                  Text(
                                    context
                                                .read<LanguageBloc>()
                                                .state
                                                .selectedLanguage ==
                                            Language.english
                                        ? state.errorMsg
                                        : AppLocalizations.of(context)!
                                            .theserverisnotresponding,
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
