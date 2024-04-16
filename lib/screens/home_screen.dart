import 'package:flutter/material.dart';
import 'package:flutter_docs/colors.dart';
import 'package:flutter_docs/repository/auth_repository.dart';
import 'package:flutter_docs/repository/document_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref) {
    ref.read(authrepositoryProvider).signout();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(WidgetRef ref, BuildContext context) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);

    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => createDocument(
              ref,
              context,
            ),
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(
              Icons.logout,
              color: kredColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          data!.uid,
        ),
      ),
    );
  }
}
