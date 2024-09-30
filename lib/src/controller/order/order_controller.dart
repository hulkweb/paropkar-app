import 'package:flutter/cupertino.dart';
// ignore: unused_import
import 'package:paropkar/src/models/order_model/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';

class OrderController extends ChangeNotifier {
  List<OrderModel> _orderList = [];
  bool _isLoading = false;

  List<OrderModel> get orderList => _orderList;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Place an order
  Future<void> placeOrder(BuildContext context, {
    required String addressId,
    required String paymentType,
    required String paymentStatus,
  }) async {
    _setLoading(true);
    final body = {
      'address_id': addressId,
      'payment_type': paymentType,
      'payment_status': paymentStatus,
    };

    await postApi(
      body: body,
      url: 'https://yourapi.com/placeOrder',
      context: context,
      onSuccess: (response) {
        print('Order placed successfully!');
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
    _setLoading(false);
  }

  // Update payment status
  Future<void> updatePaymentStatus(BuildContext context, {
    required String paymentStatus,
    required String paymentType,
    required String orderId,
    required String transactionId,
  }) async {
    _setLoading(true);
    final body = {
      'payment_status': paymentStatus,
      'payment_type': paymentType,
      'order_id': orderId,
      'transaction_id': transactionId,
    };

    await postApi(
      body: body,
      url: 'https://yourapi.com/updatePaymentStatus',
      context: context,
      onSuccess: (response) {
        print('Payment status updated successfully!');
        notifyListeners();
      },
      onFailed: (error) {
        print('Failed to update payment status: $error');
      },
      onException: () {
        print('Exception occurred while updating payment status');
      },
      loader: true,
    );
    _setLoading(false);
  }

  // Get order list
  Future<void> getOrderList(BuildContext context) async {
    _setLoading(true);

    await getApi(
      url: 'https://yourapi.com/getOrderList',
      context: context,
      onSuccess: (response) {
        // _orderList = ; // Parse response into your OrderModel list
        notifyListeners();
      },
      onFailed: (error) {
        print('Failed to fetch order list: $error');
      },
      onException: () {
        print('Exception occurred while fetching order list');
      },
      loader: true,
    );
    _setLoading(false);
  }
}
