import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/models/notification/notification_model.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/checkout/checkout_widgets.dart';
import 'package:paropkar/src/view/order/order_list_screen.dart';

class NotificationController with ChangeNotifier {
  NotificationController() {
    if (kDebugMode) {
      print('CheckoutController created');
    }
  }

  /// description

  List<NotificationModel> notificationList = [
    NotificationModel(
      title: "Fresh Food",
      description: "27-29 april on selected pulses, flour ",
    ),
    NotificationModel(
      title: "Fresh Food",
      description: "27-29 april on selected pulses, flour ",
    ),
    NotificationModel(
      title: "Fresh Food",
      description: "27-29 april on selected pulses, flour ",
    ),
  ];

  ontapGoBack(BuildContext context) {
    Navigator.pop(context);
  }
}
