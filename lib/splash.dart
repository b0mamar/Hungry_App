import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hangry_app/core/constants/app_colors.dart';
import 'package:hangry_app/features/auth/view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoRotate;
  late final Animation<double> _logoFade;
  late final Animation<Alignment> _bgAlignment;
  late final Animation<Offset> _bottomSlide;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.6,
          end: 1.08,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.08,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
    ]).animate(_ctrl);

    _logoRotate = Tween<double>(begin: -0.08, end: 0.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _bgAlignment = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));

    _bottomSlide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: Interval(0.5, 1.0, curve: Curves.elasticOut),
          ),
        );

    _ctrl.forward();

    // navigate when animation completes
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginView()));
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset(
      'assets/logo/logo.svg',
      width: 140,
      height: 140,
    );

    return Scaffold(
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: _bgAlignment.value,
                end: Alignment.center,
                colors: [
                  AppColors.primaryColor.withOpacity(0.95),
                  Colors.deepOrangeAccent.shade200.withOpacity(0.9),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Opacity(
                    opacity: _logoFade.value,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..scale(_logoScale.value)
                        ..rotateZ(_logoRotate.value),
                      child: heroize(logo),
                    ),
                  ),
                  const Gap(24),
                  Text(
                    'Hangry',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 28 + 4 * _logoScale.value,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                  SlideTransition(
                    position: _bottomSlide,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Image.asset(
                        'assets/splash/splash.png',
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget heroize(Widget child) {
    // subtle glowing circle behind logo
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: Offset(0, 8 * (1 - _logoFade.value)),
          child: Container(
            width: 180 * _logoScale.value,
            height: 180 * _logoScale.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.14 * _logoFade.value),
                  Colors.transparent,
                ],
                radius: 0.9,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
