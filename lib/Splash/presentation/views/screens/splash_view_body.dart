import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/utils/assets.dart';
import '../../../../curved_navigation_bar/presentaion/screens/nav_bar_screen.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late Animation<double> _textOpacityAnimation;
  bool _imageAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_controller);

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _imageAnimationCompleted = true;
        });
      }
    });

    Future.delayed(
      const Duration(milliseconds: 6000),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavBarScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _animation,
              child: SvgPicture.asset(
                AssetsData.splashText,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _imageAnimationCompleted ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: FadeTransition(
                opacity: _textOpacityAnimation,
                child: Text(
                  'Discover the world of movies',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    letterSpacing: 1,
                    color: textTheme.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
