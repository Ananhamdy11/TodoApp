import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  void _onIntroEnd(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Task Organization",
      body: "Plan your tasks to stay organized and not miss anything.",
      image: Center(
        child: Image.asset(
          "assets/images/Premium PSD _ 3d render calendar icon isolated 1.png",
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
        imagePadding: EdgeInsets.all(24),
      ),
    ),
    PageViewModel(
      title: "Weekly Schedule",
      body: "Create a full schedule for the whole week and stay productive.",
      image: Center(
        child: Image.asset(
          "assets/images/team-management-5806312-4863041 1.png",
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
        imagePadding: EdgeInsets.all(24),
      ),
    ),
    PageViewModel(
      title: "Team Tasks",
      body: "Create a team task, invite people, and manage work together.",
      image: Center(
        child: Image.asset(
          "assets/images/3d Shield protected icon with check 1.png",
          width: 200,
          fit: BoxFit.contain,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 16),
        imagePadding: EdgeInsets.all(24),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Text("Next"),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
