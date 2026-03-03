import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/router/route_names.dart';
import 'package:jobify_project/presentation/onboarding/view/widgets/onboarding_buttons.dart';
import 'package:jobify_project/presentation/onboarding/view/widgets/onboarding_indicators.dart';
import 'package:jobify_project/presentation/onboarding/view/widgets/onboarding_page_widget.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_cubit.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_event.dart';
import 'package:jobify_project/presentation/onboarding/view_model/onboarding_state.dart';
import 'package:jobify_project/generated/l10n.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final pages = [
      OnboardingPageWidget(
        title: local.searchJobEasier,
        description: local.makeYourExperience,
        imagePlaceholder: Image.asset(
          AppImages.onboarding3,
          fit: BoxFit.cover,
          cacheWidth: 600,
        ),
      ),
      OnboardingPageWidget(
        title: local.applyForJob,
        description: local.jobfilMakesYou,
        imagePlaceholder: Image.asset(
          AppImages.onboarding2,
          fit: BoxFit.cover,
          cacheWidth: 600,
        ),
      ),
      OnboardingPageWidget(
        title: local.helpFindRightJob,
        description: local.jobfilCanHelp,
        imagePlaceholder: Image.asset(
          fit: BoxFit.cover,
          AppImages.onboarding1,
          cacheWidth: 600,
        ),
      ),
    ];

    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.isCompleted) {
          context.go(RouteNames.login);
        } else if (_pageController.hasClients &&
            _pageController.page?.round() != state.currentPageIndex) {
          _pageController.animateToPage(
            state.currentPageIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        final isLastPage = state.currentPageIndex == pages.length - 1;

        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().onPageChanged(
                    OnboardingPageChangedEvent(index),
                  );
                },
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),
            OnboardingIndicators(
              totalPages: pages.length,
              currentIndex: state.currentPageIndex,
            ),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),
            OnboardingButtons(totalPages: pages.length, isLastPage: isLastPage),
            const SizedBox(height: AppMeasurements.paddingExtraLarge),
          ],
        );
      },
    );
  }
}
