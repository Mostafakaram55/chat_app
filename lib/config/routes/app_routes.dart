import 'dart:io';

import 'package:cubit_pro/config/routes/routes_name.dart';
import 'package:cubit_pro/core/di/di.dart';
import 'package:cubit_pro/featuers/auth/presentation/authe_cubit/cubit.dart';
import 'package:cubit_pro/featuers/auth/presentation/pages/login_view.dart';
import 'package:cubit_pro/featuers/auth/presentation/pages/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.loginView,
  routes: [
    GoRoute(
      path: Routes.loginView,
      name: Routes.loginView,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => getIt.get<AuthCubit>(),
            child: const LogInView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.ease)),
              ),
              child: child,
            );
          },
        );
      },
    ),
      GoRoute(
      path: Routes.signUpView,
      name: Routes.signUpView,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => getIt.get<AuthCubit>(),
            child: const SignUpView(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.ease)),
              ),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

RouteSettings _buildPageWithSlideTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  TextDirection? textDirection,
}) {
  if (Platform.isIOS) {
    return CupertinoPage(key: state.pageKey, child: child);
  } else {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 600),
      reverseTransitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const slideBegin = Offset(1.0, 0.0);
        const slideEnd = Offset.zero;
        const slideCurve = Curves.easeOutCubic;
        var slideTween = Tween(
          begin: slideBegin,
          end: slideEnd,
        ).chain(CurveTween(curve: slideCurve));
        var slideAnimation = animation.drive(slideTween);

        const fadeBegin = 1.0;
        const fadeEnd = 0.0;
        var fadeOutTween = Tween(
          begin: fadeBegin,
          end: fadeEnd,
        ).chain(CurveTween(curve: Curves.easeOutCubic));
        var fadeOutAnimation = secondaryAnimation.drive(fadeOutTween);

        return AnimatedBuilder(
          animation: secondaryAnimation,
          builder: (context, child) {
            return FadeTransition(
              opacity: fadeOutAnimation,
              child: SlideTransition(
                textDirection: textDirection ?? TextDirection.rtl,
                position: slideAnimation,
                child: child!,
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}

Page<T> adaptivePage<T>({
  required Widget child,
  required LocalKey key,
  PageTransitionsBuilder? transitionBuilder,
}) {
  if (Platform.isIOS) {
    return CupertinoPage<T>(key: key, child: child);
  } else {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionsBuilder: transitionBuilder != null
          ? (context, animation, secondaryAnimation, child) {
              return transitionBuilder.buildTransitions<T>(
                PageRouteBuilder<T>(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      child,
                ),
                context,
                animation,
                secondaryAnimation,
                child,
              );
            }
          : (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
    );
  }
}
