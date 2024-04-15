import 'package:flutter/material.dart';
import 'package:flutter_docs/models/error_model.dart';
import 'package:flutter_docs/repository/auth_repository.dart';
import 'package:flutter_docs/screens/home_screen.dart';
import 'package:flutter_docs/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    errorModel = await ref.read(authrepositoryProvider).getUserData();
    print(errorModel!.data);
    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update(
            (state) => errorModel!.data,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: user != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}
