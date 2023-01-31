import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_redirection_screen_controller.dart';

class NotificationRedirectionScreenView
    extends GetWidget<NotificationRedirectionScreenController> {
  const NotificationRedirectionScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationRedirectionScreenView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Container(
          alignment: Alignment.center,
          child: Text("${controller.id.value} \n Message: = ${controller.message.value}"),
        );
      }),
    );
  }
}
