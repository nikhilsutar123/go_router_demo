import 'dart:io';

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
      initialLocation: "/",
      redirect: (context, state) {
        final uri = state.uri;
        if (uri.scheme.isNotEmpty || uri.authority.isNotEmpty) {
          String routePath = "/${uri.authority}${uri.path}";
          print("path $routePath");
          return routePath;
        }
        return null;
      },
      routes: <RouteBase>[
        GoRoute(path: "/", builder: (context, state) => const HomePage()),
        GoRoute(
          path: "/details/:id",
          builder: (context, state) {
            return DetailPage(userId: state.pathParameters["id"]!);
          },
        ),
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
            context.push('/details/42');
          },
          child: const Text("Go to Details page"),
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
      appBar: AppBar(
        title: const Text('Profile'),
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              )
            : null,
      ),
      body: Center(child: Text('Profile Page for user $userId')),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String userId;

  const DetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              )
            : null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detail Page for user $userId'),
            ElevatedButton(
              onPressed: () {
                context.push('/profile/42');
              },
              child: const Text("Go to Profile page"),
            ),
          ],
        ),
      ),
    );
  }
}
