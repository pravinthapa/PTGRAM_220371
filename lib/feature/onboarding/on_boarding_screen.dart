import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptgram/common/app/theme.dart';
import 'package:ptgram/common/navigation/navigation_service.dart';
import 'package:ptgram/feature/auth/page/login_page.dart';
import 'package:ptgram/feature/onboarding/onboard_cubit.dart';
import 'package:ptgram/feature/onboarding/onboard_page.dart';
import 'package:ptgram/feature/onboarding/smooth_page_indicator.dart';

class OnBoardScreenWidget extends StatefulWidget {
  const OnBoardScreenWidget({super.key});

  @override
  State<OnBoardScreenWidget> createState() => _OnBoardScreenWidgetState();
}

class _OnBoardScreenWidgetState extends State<OnBoardScreenWidget> {
  late PageController controller;

  bool IsLastPlace = false;
  bool onboardCompleted = false;

  @override
  void initState() {
    controller = PageController();
    // HiveStorage().checkOnboardingCompleted();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkLastPage(int index) {
    return setState(() {
      IsLastPlace = index == 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) => checkLastPage(index),
          children: [
            OnboardPage(
              color: Colors.white,
              urlImage: "assets/images/onbaording.png",
              title: "Welcome To PTGRAM",
              subtitle: "Welcome TO PTGRAM",
            ),
          ],
        ),
      ),
      bottomSheet: IsLastPlace
          ? BlocBuilder<OnboardingCubit, int>(
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Container(
                    height: screenheight * 0.060,
                    width: screenwidth * 0.60,
                    decoration: BoxDecoration(
                      color: CustomTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (IsLastPlace) {
                            // HiveStorage().markOnboardingCompleted();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } else {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text("Explore")),
                  ),
                );
              },
            )
          : Container(
              color: Colors.white,
              height: screenheight * 0.0991,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (IsLastPlace) {
                        //    _markOnboardingCompleted();
                        // HiveStorage().markOnboardingCompleted();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      } else {
                        controller.jumpToPage(2);
                      }
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: CustomTheme.primaryColor,
                      ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller, pageCount: 3,

                      // count: 3,
                      // effect: const WormEffect(
                      //   spacing: 16,
                      //   radius: 15,
                      //   dotHeight: 8,
                      //   dotWidth: 8,
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        NavigationService.push(target: LoginPage());
                        // controller.nextPage(
                        //     duration: Duration(milliseconds: 500),
                        //     curve: Curves.easeInOut);
                      },
                      child: Text("Next"),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
