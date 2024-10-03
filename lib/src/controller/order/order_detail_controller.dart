import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/order_model/order_detai_model.dart';
import 'package:paropkar/src/models/order_model/product_order_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/order/customer_detail_screen.dart';
import 'package:paropkar/src/view/order/order_detail_screen.dart';

class OrderDetailController with ChangeNotifier {
  OrderDetailModel? orderDetailData;

  DataStatus _orderDataStatus = DataStatus.loading;
  DataStatus get orderDataStatus => _orderDataStatus;
  changeDataStatus(DataStatus status) {
    _orderDataStatus = status;
    notifyListeners();
  }

  orderDetail(String orderId){
    changeDataStatus(DataStatus.loading);
    getApi(
      url: '${AppUrl.order_detail}?order_id=$orderId',
      onSuccess: (response) {
        orderDetailData = OrderDetailModel.fromJson(response);
        changeDataStatus(DataStatus.success);
      },
      onFailed: (response) {
        changeDataStatus(DataStatus.error);
      },
    );
  }

  ontapCustomerButton(BuildContext context) {
    AppNavigation.navigationPush(context, const CustomerDetailScreen());
  }


  String _orderStatus = 'readyToPickup';
  String get orderSatus => _orderStatus;

  chnageStatus(String status) {
    //status keys = readyToPickup,orderProcessed,paymentConfirm,orderPlaced
    _orderStatus = status;
    notifyListeners();
  }

}
