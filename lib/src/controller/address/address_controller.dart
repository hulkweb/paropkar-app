import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/address/address_model.dart';
import 'package:paropkar/src/services/get_api.dart';
import 'package:paropkar/src/services/post_api.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';

class AddressController extends ChangeNotifier {
  AddressController() {
    // getAddressApi(BuildContext context);
  }
  // text fields
  final mobileFieldController = TextEditingController();
  final nameController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final localAddressController = TextEditingController();
  final landMarkController = TextEditingController();
  void clearAllControllers() {
    mobileFieldController.clear();
    nameController.clear();
    pincodeController.clear();
    stateController.clear();
    cityController.clear();
    localAddressController.clear();
    landMarkController.clear();
  }

//validations
  String? mobileValidation(value) {
    return validatePhone(value);
  }

  String? nameValidation(value, {String? emptyText}) {
    if (value!.isEmpty) {
      return emptyText ?? 'Enter Your Full Name';
    }
    return null;
  }

  String? pincodeValidation(value) {
    if (value!.isEmpty) {
      return 'Enter Your Pincode';
    }
    if (value!.length < 6) {
      return 'Enter Valid Pincode';
    }
    return null;
  }

  AddressType _selectedAddressType = AddressType.home; // Default to home

  AddressType get selectedAddressType => _selectedAddressType;

  void setAddressType(AddressType type) {
    _selectedAddressType = type;
    notifyListeners(); // This will notify any listeners (UI) to rebuild
  }

  assignAddressValue({
    required String name,
    required String phoneNumber,
    required String pinCode,
    required String state,
    required String city,
    required String addressMain,
    required String addressLandmark,
    required AddressType addressType,
  }){
    nameController.text = name;
    mobileFieldController.text = phoneNumber;
    pincodeController.text = pinCode;
    stateController.text = state;
    cityController.text = city;
    localAddressController.text = addressMain;
    landMarkController.text = addressLandmark;
    setAddressType(addressType);
  }
  ButtonStatus _addUpdateAddressStatus = ButtonStatus.nothing;
  ButtonStatus get addressAddUpdateStatus => _addUpdateAddressStatus;

  changeButtonStatus(ButtonStatus value) {
    _addUpdateAddressStatus = value;
    ChangeNotifier();
  }

  AddressListModel _addressListData = AddressListModel();
  AddressListModel get addressListData => _addressListData;
  DataStatus _addressDataStatus = DataStatus.loading;
  DataStatus get addressDataStatus => _addressDataStatus;

  changeAddressDataStatus(DataStatus value) {
    _addressDataStatus = value;
    notifyListeners();
  }

  String defaultAddressId = '';
  String getDefaultAddressId() {
    for (int i = 0; i < _addressListData.data!.length; i++) {
      if (_addressListData.data![i].isDefault == 1) {
        return _addressListData.data![i].id.toString();
      }
    }
    return '';
  }

  String _selectedAddressId = '';
  String get selectedAddressId => _selectedAddressId;

  setAddressId(String value) {
    _selectedAddressId = value;
    print('set address id');
    notifyListeners();
  }

  bool isSelected(String value) {
    bool isSelected = (_selectedAddressId == value);
    notifyListeners();
    return isSelected;
  }

  getAddressApi(BuildContext context) {
    changeAddressDataStatus(DataStatus.loading);
    getApi(
      url: AppUrl.getAddress,
      onSuccess: (response) {
        _addressListData = AddressListModel.fromJson(response);
        if (defaultAddressId.isEmpty) {
          defaultAddressId = getDefaultAddressId();
          setAddressId(defaultAddressId);
        }
        changeAddressDataStatus(DataStatus.success);
        notifyListeners();
      },
      onFailed: (response) {
        if (kDebugMode) {
          print('here');
        }
        _addressListData = AddressListModel.fromJson(response);
        changeAddressDataStatus(DataStatus.success);
      },
      onException: () {
        if (kDebugMode){
          print('here error');
        }
        changeAddressDataStatus(DataStatus.error);
      },
    );
  }

  ontapSaveAddress(BuildContext context, String? addressId) async {
    addUpdateAddressApi(context,
        name: nameController.text,
        phoneNumber: mobileFieldController.text,
        pinCode: pincodeController.text,
        state: stateController.text,
        city: cityController.text,
        addressMain: localAddressController.text,
        addressText: landMarkController.text,
        addressType: selectedAddressType,
        addressId: addressId);
  }

  addUpdateAddressApi(
    BuildContext context, {
    required String name,
    required String phoneNumber,
    required String pinCode,
    required String state,
    required String city,
    required String addressMain,
    required String addressText,
    required AddressType addressType,
    String? addressId,
  }) async {
    print('enter');
    if (_addUpdateAddressStatus == ButtonStatus.loading) return;
    changeButtonStatus(ButtonStatus.loading);
    Map<String, String> bodyField = {
      'name': name,
      'phone': phoneNumber,
      'address': addressMain,
      'area': addressText,
      'state': state,
      'city': city,
      'postal_code': pinCode,
      'country': '+91',
      'type': addressType == AddressType.home ? 'home' : 'office'
    };
    print(addressId);
    if (addressId != null) {
      bodyField.addAll({'address_id': addressId});
    }
    await postApi(
      url: AppUrl.addressAddUpdate,
      body: bodyField,
      context: context,
      onSuccess: (response) {
        changeButtonStatus(ButtonStatus.nothing);
        getAddressApi(context);
        Navigator.pop(context);
      },
      onFailed: (response) {
        changeButtonStatus(ButtonStatus.nothing);
      },
      onException: () {
        changeButtonStatus(ButtonStatus.nothing);
      },
    );
  }

  OverlayStatus _removeAddressStatus = OverlayStatus.nothing;
  OverlayStatus get removeAddressStatus => _removeAddressStatus;

  changeRemoveOverlayStatus(OverlayStatus value) {
    _removeAddressStatus = value;
    ChangeNotifier();
  }

  removeAddressApi(
    BuildContext context, {
    required String addressId,
  }) {
    changeRemoveOverlayStatus(OverlayStatus.loading);
    postApi(
      url: AppUrl.deleteAddress,
      body: {'address_id': addressId},
      context: context,
      onSuccess: (response) {
        changeRemoveOverlayStatus(OverlayStatus.nothing);
        getAddressApi(context);
      },
      onFailed: (response) {
        changeRemoveOverlayStatus(OverlayStatus.nothing);
      },
      onException: () {
        changeRemoveOverlayStatus(OverlayStatus.nothing);
      },
    );
  }

  OverlayStatus _defaultAddressStatus = OverlayStatus.nothing;
  OverlayStatus get defaultAddressStatus => _defaultAddressStatus;

  changeDefaultAddressOverlayStatus(OverlayStatus value) {
    _defaultAddressStatus = value;
    ChangeNotifier();
  }

  defaultAddressApi(
    BuildContext context, {
    required String addressId,
  }) {
    if (_defaultAddressStatus == OverlayStatus.loading) return;
    changeDefaultAddressOverlayStatus(OverlayStatus.loading);
    postApi(
      url: AppUrl.defaultAddress,
      body: {'address_id': addressId},
      context: context,
      onSuccess: (response) {
        changeDefaultAddressOverlayStatus(OverlayStatus.nothing);
        getAddressApi(context);
      },
      onFailed: (response) {
        changeDefaultAddressOverlayStatus(OverlayStatus.nothing);
      },
      onException: () {
        changeDefaultAddressOverlayStatus(OverlayStatus.nothing);
      },
    );
  }
}

enum AddressType {
  home,
  office,
}
