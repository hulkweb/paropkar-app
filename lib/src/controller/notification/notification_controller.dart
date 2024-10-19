import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/notification/notification_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/constants.dart';
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
  ontapGoBack(BuildContext context) {
    Navigator.pop(context);
  }

  NotifitionModel? notification;
  DataStatus _notificationStatus = DataStatus.loading;
  DataStatus get notificationDataStatus => _notificationStatus;
  changeNotificationDataStatus(DataStatus status) {
    _notificationStatus = status;
    print('status changed of getcart $status');
    notifyListeners();
  }

  // Get notification post
  Future<NotifitionModel?> readNotification(
      BuildContext context, String id) async {
    NotifitionModel? notificationTempData;
    
    await postApi(
      isShowMessageToast: false,
      url: AppUrl.notification_read,
      context: context,
      onSuccess: (response) {
        getNotificationList(context);
        return notificationTempData;
      },
      onFailed: (error) {
        changeNotificationDataStatus(
            DataStatus.success); // Parse response into your OrderModel list
        notifyListeners();
      },
      onException: () {},
      loader: false,
      body: {'id': id},
    );
    return notificationTempData;
  }

  // Get notification list
  getNotificationList(BuildContext context) async {
    await getApi(
      url: AppUrl.getnotification,
      context: context,
      onSuccess: (response) {
        notification = NotifitionModel.fromJson(response);
        changeNotificationDataStatus(DataStatus.success);
      },
      onFailed: (error) {
        if (kDebugMode) {
          print('Failed to fetch order list: $error');
        }
        changeNotificationDataStatus(
            DataStatus.success); // Parse response into your OrderModel list
      },
      onException: () {
        if (kDebugMode) {
          print('Exception occurred while fetching order list');
        }
      },
      loader: false,
    );
  }
}
