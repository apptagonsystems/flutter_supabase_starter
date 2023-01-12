import 'package:all_in_one/services/AuthenticationRepository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("WELCOME PAGE"),
          ElevatedButton(
              onPressed: () async {
                try {
                  await AuthenticationRepository().registerUserWithEmail(
                      email: "snavebaby@gmail.com", password: "snave246");
                } on PostgrestException catch (error) {
                  print('${error.message}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${error.message}"),
                  ));
                } on AuthException catch (error) {
                  print('${error.message}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${error.message}"),
                  ));
                } catch (error) {
                  print('${error}');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${error}"),
                  ));
                }
              },
              child: const Text("register"))
        ],
      ),
    );
  }
}
