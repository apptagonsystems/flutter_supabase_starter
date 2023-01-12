import 'package:all_in_one/blocs/auth/auth_bloc.dart';
import 'package:all_in_one/screens/RootScreen.dart';
import 'package:all_in_one/services/AuthenticationRepository.dart';
import 'package:all_in_one/utils/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize supabase
  await Supabase.initialize(
    url: AppConstants.supabaseURL,
    anonKey: AppConstants.supabaseAnonKey,
  );

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  // run app
  runApp(MyApp(authenticationRepository: authenticationRepository));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  const MyApp({Key? key, required this.authenticationRepository})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authenticationRepository: authenticationRepository,
      )..add(AuthStarted()),
      child: RootScreen(authenticationRepository: authenticationRepository),
    );
  }
}
