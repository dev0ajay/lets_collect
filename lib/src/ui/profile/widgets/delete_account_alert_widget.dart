import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import '../../../bloc/delete_account/delete_account_bloc.dart';
import '../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteAccountAlertOverlay extends StatefulWidget {
  const DeleteAccountAlertOverlay({super.key});

  @override
  State<StatefulWidget> createState() => DeleteAccountAlertOverlayState();
}

class DeleteAccountAlertOverlayState extends State<DeleteAccountAlertOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool isEmailNotVerifyExecuted = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  Future<void> _signOut() async {
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountLoaded) {
          if (state.deleteAccountRequestResponse.success == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.secondaryColor,
                content: Text(
                  state.deleteAccountRequestResponse.message,
                  style: const TextStyle(color: AppColors.primaryWhiteColor),
                ),
              ),
            );
            context.go('/login');
          }
        }
      },
      builder: (context, state) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(15.0),
                  height: 300,
                  decoration: ShapeDecoration(
                      color: AppColors.primaryWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 20.0, right: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!.areyousure,
                            // "Are you sure ?",
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 20.0, right: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!.youraccountwillbepermanentlydeleted,
                            // "Your account will be permanently deleted",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, left: 20.0, right: 20.0),
                            child: BlocBuilder<DeleteAccountBloc,
                                DeleteAccountState>(
                              builder: (context, state) {
                                if (state is DeleteAccountLoading) {
                                  return const Center(
                                    child: RefreshProgressIndicator(
                                      color: AppColors.secondaryColor,
                                      backgroundColor:
                                      AppColors.primaryWhiteColor,
                                    ),
                                  );
                                } else {
                                  return Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(100, 40),
                                          backgroundColor:
                                          AppColors.secondaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          BlocProvider.of<DeleteAccountBloc>(
                                              context)
                                              .add(
                                            DeleteAccountEventTrigger(),
                                          );
                                          ObjectFactory()
                                              .prefs
                                              .setIsLoggedIn(false);
                                          ObjectFactory().prefs.clearPrefs();
                                          _signOut();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.yes,
                                          // "Yes",
                                          style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            color: AppColors.primaryWhiteColor,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(100, 40),
                                          backgroundColor:
                                          AppColors.secondaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          context.pop();
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.no,
                                          // "No",
                                          style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            color: AppColors.primaryWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          )),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}