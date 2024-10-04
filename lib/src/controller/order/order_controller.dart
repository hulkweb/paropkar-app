import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/models/order_model/order_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/user_preference/user_pref/user_preference.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/checkout/checkout_widgets.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderController with ChangeNotifier {
  // Place an order
  Future<void> placeOrder(
    BuildContext context, {
    required String addressId,
    required String paymentType,
    required String paymentStatus,
  }) async {
    // print('================================');
    // String? token = await getToken();
    // print(token??'');
    // return;
    // _setLoading(true);
    final body = {
      'address_id': addressId,
      'payment_type': paymentType,
      'payment_status': paymentStatus,
    };
    print('enter in the api placeOrder');
    print(body);
    await postApi(
      body: body,
      isShowMessageToast: true,
      url: AppUrl.placeOrder,
      context: context,
      onSuccess: (response) {
        print('++++++response+++++');
        print(response);
        showDialog(
          context: context,
          builder: (BuildContext context) => OrderSuccessPopup(
            text:
                'Your order #${response['data'].toString()} is successfully placed',
            onTrackOrder: () {
              Navigator.pop(context);
              AppNavigation.navigationPush(context,
                  OrderDetailScreen(orderId: response['data'].toString()));
            },
            ontapGoBack: () {
              AppNavigation.pushAndRemoveUntil(context, BottomBarListScreen());
              Provider.of<BottomBarListController>(context).changeIndex(2);
            },
          ),
        );
        notifyListeners();
      },
      onFailed: (error) {
        print('Failed to place order: $error');
      },
      onException: () {
        print('Exception occurred while placing order');
      },
      loader: true,
    );
  }

  // Update payment status
  Future<void> updatePaymentStatus(
    BuildContext context, {
    required String paymentStatus,
    required String paymentType,
    required String orderId,
    required String transactionId,
  }) async {
    final body = {
      'payment_status': paymentStatus,
      'payment_type': paymentType,
      'order_id': orderId,
      'transaction_id': transactionId,
    };
    await postApi(
      body: body,
      url: '',
      context: context,
      onSuccess: (response) {
        if (kDebugMode) {
          print('Payment status updated successfully!');
        }
        notifyListeners();
      },
      onFailed: (error) {
        if (kDebugMode) {
          print('Failed to update payment status: $error');
        }
      },
      onException: () {
        print('Exception occurred while updating payment status');
      },
      loader: true,
    );
  }

  OrderModel? orders;
  DataStatus _ordersDataStatus = DataStatus.loading;
  DataStatus get ordersDataStatus => _ordersDataStatus;
  changeOrdersDataStatus(DataStatus status) {
    _ordersDataStatus = status;
    print('status changed of getcart $status');
    notifyListeners();
  }

  // Get order list
  Future<void> getOrderList(BuildContext context) async {
    await getApi(
      url: AppUrl.orders,
      context: context,
      onSuccess: (response) {
        orders = OrderModel.fromJson(response);
        changeOrdersDataStatus(
            DataStatus.success); // Parse response into your OrderModel list
        notifyListeners();
      },
      onFailed: (error) {
        print('Failed to fetch order list: $error');
      },
      onException: () {
        print('Exception occurred while fetching order list');
      },
      loader: false,
    );
  }
}
