import 'package:flutter/material.dart';
import 'package:flutter_docs/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userProvider);
    return Scaffold(
      body: Center(
        child: Text(
          data!.uid,
        ),
      ),
    );
  }
}