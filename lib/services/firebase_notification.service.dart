import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/messages.page.dart';
import '../pages/settings.page.dart';
import 'local_notification.service.dart';

class FirebaseNotificationService {
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();

  Future<void> initialize() async {
    await FirebaseMessaging.instance.requestPermission(provisional: true);

    final fcmToken = await FirebaseMessaging.instance.getToken();

    log("Token = $fcmToken");

    //mostra a notificação quando o app está aberto
    FirebaseMessaging.onMessage
        .listen(_localNotificationService.showLocalNotification);
    //mostra a notificação quando o app está em segundo plano
    FirebaseMessaging.onMessageOpenedApp.listen(_onTapNotification);
  }

  void _onTapNotification(RemoteMessage message) {
    log("A notificação foi clicada");
    log(message.notification!.title!);
    log(message.notification!.body!);
    log(jsonEncode(message.data));

    final String? navigateTo = message.data['navigateTo'];

    if (navigateTo != null) {
      if (navigateTo == 'messages') {
        Navigator.of(globalNavigatorKey.currentState!.context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MessagesPage(),
          ),
        );
      }
      if (navigateTo == 'settings') {
        Navigator.of(globalNavigatorKey.currentState!.context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const SettingsPage(),
          ),
        );
      }
    }
  }
}
