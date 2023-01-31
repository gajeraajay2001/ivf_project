import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/services/notification_handler.dart';
import 'package:flutter_notification_channel/notification_importance.dart'
    as imp;
import 'package:http/http.dart' as http;

class AwesomeNotificationService {
  static String icon = "resource://drawable/notification_icon";
  static NotificationChannel channel = NotificationChannel(
    channelGroupKey: "basic_channel",
    channelKey: "basic_channel",
    channelName: "Ivf Notification",
    channelDescription: "Notification channel  for default notifications",
    ledColor: Colors.blue,
  );

  static init() async {
    await requestPermission();
    await AwesomeNotifications().initialize(icon, [
      channel
    ], channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: "basic_channel",
        channelGroupName: "Ivf Notification",
      ),
    ]);
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    print("FCM := $fcmToken");
    await AwesomeNotificationHandler.init();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AwesomeNotificationService.showNotification(
        message: message,
      );
    });
  }

  static Future<void> showNotification({required RemoteMessage message}) async {
    Map<String, String> dict = {};
    if (!isNullEmptyOrFalse(message.data)) {
      dict["title"] = message.data["title"];
      dict["body"] = message.data["body"];
      dict["id"] = message.data["id"];
    }
    print(message);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(100),
          channelKey: "basic_channel",
          title: dict["title"],
          body: dict["body"],
          payload: dict,
          autoDismissible: true,
          category: NotificationCategory.Recommendation,
          displayOnForeground: true,
          displayOnBackground: true,
        ),
        actionButtons: [
          NotificationActionButton(
            key: "show_details",
            label: "Data",
            isDangerousOption: true,
            actionType: ActionType.DismissAction,
            requireInputText: true,
            autoDismissible: true,
          ),
        ]);
  }

  static requestPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then((value) async {
      if (!value) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
        await AwesomeNotifications().setChannel(channel, forceUpdate: true);
        await FlutterNotificationChannel.registerNotificationChannel(
          description: 'Tapn Channel',
          id: 'basic_channel',
          importance: imp.NotificationImportance.IMPORTANCE_HIGH,
          name: 'basic_channel',
          visibility: NotificationVisibility.VISIBILITY_PUBLIC,
          allowBubbles: true,
          enableVibration: true,
          enableSound: true,
          showBadge: true,
        );
      }
    });
  }

  static Future<void> sendPushNotification({
    required String nTitle,
    required String nBody,
    required String nType,
    required String nSenderId,
    required String nUserDeviceToken,
    // Call Info Map Data
    Map<String, dynamic>? nCallInfo,
  }) async {
    // Variables
    final Uri url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    await http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=	AAAAOdydd-M:APA91bGV95OrueCrDuncyLUz7mXolkAxZApLLQxENuG6uazFLRklJe7FOVw6drdD52ZV8Nm2J8ZKH3L2FnhTu9YHU92bw0e2tYK7Dm4xlr4ORWtWS1TdXTw6s9iO32IxfOyn0mJrnpSw',
      },
      body: jsonEncode(
        <String, dynamic>{
          // 'notification': <String, dynamic>{
          //   'title': nTitle,
          //   'body': nBody,
          //   'color': '#F1F7B5',
          //   'priority': 'high',
          //   'sound': "default"
          // },
          'priority': 'high',
          'data': <String, dynamic>{
            "title": "testing....",
            "body": "body.................................."
          },
          'to':
              "d7e9BYwIQaa_3tVbgmkACa:APA91bG6dkTTE75zgX9qBQLZfbHpv9j_aiErQBjwFLPDOCXdmGs6seU_Rae2Jzv2-NJlF2knDpv8jMKsmHZSPLguWNKplrq2A5nWJFaxfw8x6vuo-uryeLCPejw_d2kgyU-bLMKvPRXo",
        },
      ),
    )
        .then((http.Response response) {
      if (response.statusCode == 200) {
        print('sendPushNotification() -> success');
      }
    }).catchError((error) {
      print('sendPushNotification() -> error: $error');
    });
  }
}
