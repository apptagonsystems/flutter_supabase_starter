import 'dart:async';

import 'package:all_in_one/blocs/auth/auth_bloc.dart';
import 'package:all_in_one/blocs/authentication/authentication_bloc.dart';
import 'package:all_in_one/screens/SplashScreen.dart';
import 'package:all_in_one/screens/WelcomeScreen.dart';
import 'package:all_in_one/screens/default/ErrorScreen.dart';
import 'package:all_in_one/services/AuthenticationRepository.dart';
import 'package:all_in_one/utils/AppConstants.dart';
import 'package:all_in_one/utils/AppRoutes.dart';
import 'package:all_in_one/utils/AppThemes.dart';
import 'package:all_in_one/utils/RouteGenerator.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  const RootScreen({super.key, required this.authenticationRepository});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository: AuthenticationRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.kAppName,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Montserrat",
          appBarTheme: AppThemes().appTheme,
          backgroundColor: Colors.white,
          textTheme: const TextTheme(),
          inputDecorationTheme: AppThemes().inputDecorationTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          primaryColor: Colors.black,
          primaryIconTheme: const IconThemeData(color: Colors.black),
          colorScheme: AppThemes().colorScheme,
        ),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (AuthState is AuthStarted) {
                return const SplashScreen();
              }
              if (state is AuthFailure) {
                return Scaffold(
                  body: ErrorScreen(
                    errorMessage: state.errorMessage,
                    retry: () {
                      context.read<AuthBloc>().add(
                            AuthStarted(),
                          );
                    },
                  ),
                );
              }
              if (state is AuthUnauthenticated) {
                return const WelcomeScreen();
              }

              if (state is AuthSuccess) {
                if (state.userModel.accountStatus ==
                    AppConstants.accountStatusAPPROVED) {
                  Timer(const Duration(milliseconds: 1000), () async {
                    await Navigator.of(context).pushReplacementNamed(
                      AppRoutes.mainPageRoute,
                      arguments: state.userModel,
                    );
                  });
                } else {
                  Timer(const Duration(milliseconds: 1000), () async {
                    await Navigator.of(context).pushReplacementNamed(
                      AppRoutes.loginPageRoute,
                    );
                  });
                }
              }

              return const SplashScreen();
            });
          },
        ),
        onGenerateRoute: RouteGenerator.generateMaterialRoutes,
      ),
    );
  }
}
