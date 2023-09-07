import 'dart:async';
import 'package:ecommerce_bloc/config/auth.dart';
import 'package:ecommerce_bloc/models/notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationServices notificationServices = NotificationServices();

  User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      // ignore: avoid_print
      print('Device Token: $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        Timer(
          const Duration(seconds: 2),
          () {
            //snapshot.hasData
            if (snapshot.hasData) {
              Navigator.pushNamed(context, '/');
            } else {
              Navigator.pushNamed(context, '/sign_in');
            }
          },
        );
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 125,
                  height: 125,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Zero To Unicorn',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
