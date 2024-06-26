import 'package:flutter/material.dart';
import 'package:flutter_docs/colors.dart';
import 'package:flutter_docs/repository/auth_repository.dart';
import 'package:flutter_docs/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessanger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    final errorModel = await ref
        .read(
          authrepositoryProvider,
        )
        .signInWithGoogle();
    navigator.replace('/');

    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update(
            (state) => errorModel.data,
          );
    } else {
      sMessanger.showSnackBar(
        SnackBar(
          content: Text(
            errorModel.error!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            signInWithGoogle(ref, context);
          },
          icon: Image.asset(
            'assets/images/g-logo-2.png',
            height: 20,
          ),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
