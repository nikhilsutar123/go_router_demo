import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
        redirect: (context, state){
          final uri = state.uri;
          if(uri.scheme.isNotEmpty || uri.authority.isNotEmpty){
            String routePath = "/${uri.authority}${uri.path}";
            print("path ${routePath}");
            return routePath;
          }
          return null;
        },
      routes: [
        GoRoute(path: "/", builder: (context, state) => const HomePage()),
        GoRoute(
          path: "/profile/:id",
          builder: (context, state) {
            final id = state.pathParameters['id'];
            return ProfilePage(userId: id!);
          },
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router, title: 'Flutter Demo');
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/profile/42');
          },
          child: const Text("Go to Profile page"),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(child: Text('Profile Page for user $userId')),
    );
  }
}
