import 'dart:io';
import 'package:cubit_pro/config/routes/routes_name.dart';
import 'package:cubit_pro/core/di/di.dart';
import 'package:cubit_pro/featuers/auth/presentation/authe_cubit/cubit.dart';
import 'package:cubit_pro/featuers/auth/presentation/pages/login_view.dart';
import 'package:cubit_pro/featuers/auth/presentation/pages/sign_up.dart';
import 'package:cubit_pro/featuers/chat_bot/data_sor/gemini_service.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/chat_screen.dart';
import 'package:cubit_pro/featuers/chat_bot/presentation/controller/chat_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.chatBotView,
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
    GoRoute(
      path: Routes.chatBotView,
      name: Routes.chatBotView,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => ChatCubit(GeminiService()),
            child: const ChatScreen(),
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
