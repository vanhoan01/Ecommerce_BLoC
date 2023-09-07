import 'dart:convert';

import 'package:ecommerce_bloc/config/auth.dart';
import 'package:ecommerce_bloc/models/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, required this.id});
  final String id;

  static const String routeName = '/user';
  static Route route({required String id}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => UserScreen(id: id),
    );
  }

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () async {
            try {
              await Auth().signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/sign_in');
            } catch (e) {
              // ignore: avoid_print
              print('error sign out');
            }
          },
          icon: const Icon(Icons.logout_outlined),
        )
      ]),
      body: Center(
        child: Column(
          children: [
            Text('id: ${widget.id}'),
            TextButton(
              onPressed: () {
                notificationServices.getDeviceToken().then((value) async {
                  var data = {
                    'to':
                        'f2Hb6u7CRF2XwUvqy6Z_45:APA91bEtVPUiFxei1k3csPirVWVYYCKx5x9Rlc0YrMoS6f-vqyNvATtvJbXBeh-wA2bKKFHgipVrBzYpeO5_r6TYy9xsvDPkHoRv6ufujeHakZP_veJK95oVrc6PxSPWoFkHEZzOXxE4',
                    'priority': 'high',
                    'notification': {
                      'title': 'Chia sẻ',
                      'body': 'Hoàn đã chia sẻ một bài viết',
                    },
                    'data': {
                      'type': 'msj',
                      'id': 'asif1245',
                    }
                  };
                  await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAAORqzmVs:APA91bFS2Pmk7Nj1yNNUExmklq7aGR1XeUXaqkAlRoo1xFUAOZJAjcMCIhNh_ka2fXkjnUjevZigAtzORWGxGxxDELKMMa5iZUByszUf11mf8DRxibRNBOagJ_IOF3YTNh6jHgx_gAIu',
                    },
                  );
                });
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
