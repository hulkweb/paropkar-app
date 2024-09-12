import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/order/order_list_screen.dart';
import 'package:paropkar/src/widgets/custom_image_icon.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  int _currentStatus = 0; // 0: Accepted, 1: Picked Up, 2: Delivered
  bool _isAnimating = false;
  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Accepted';
      case 1:
        return 'Picked Up';
      case 2:
        return 'Delivered';
      default:
        return '';
    }
  }

  void _changeStatus() {
    setState(() {
      _currentStatus++;
      _isAnimating = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isAnimating = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: CustomIconImage(
            backgroundColor: AppColors.primaryColor.withOpacity(.7),
            size: 20,
            icon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).cardColor,
                size: 23,
              ),
            ),
            onPress: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomIconImage(
              backgroundColor: AppColors.primaryColor.withOpacity(.7),
              icon: Icon(
                Icons.notifications_outlined,
                color: Theme.of(context).cardColor,
                size: 23,
              ),
              onPress: () {},
            ),
          ),
        ],
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),
      body: Column(
        children: [
          // Map Section
          // SizedBox(
          //   height: screenHeight*.5,  width: screenWidth,
          //   child: Expanded(
          //     child: GoogleMap(
          //       onMapCreated: (controller) {
          //         setState(() {
          //           // _mapController = controller;
          //         });
          //       },
          //       initialCameraPosition: CameraPosition(
          //         target: LatLng(3, 3), // Default to San Francisco's coordinates
          //         zoom: 12.0,
          //       ),
          //       onTap: (LatLng location) {
          //         // _addMarker(location);
          //       },
          //       // markers: _selectedLocation == null
          //       //     ? Set<Marker>()
          //       //     : {
          //       //         Marker(
          //       //           markerId: MarkerId("SelectedLocation"),
          //       //           position: _selectedLocation!,
          //       //           infoWindow: InfoWindow(title: "Selected Location"),
          //       //         ),
          //       //       },
          //     ),
          //   ),
          // ),
          // Order Status Section
          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 500),
          //   switchInCurve: Curves.easeInOut,
          //   switchOutCurve: Curves.easeInOut,
          //   child: Text(
          //     _getStatusText(_currentStatus),
          //     style: Theme.of(context).textTheme.bodyLarge,
          //     key: ValueKey<int>(_currentStatus),
          //   ),
          // ),

          SizedBox(
            height: screenHeight * .4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pickup Your Order',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your order #34567 is successfully placed',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: AppFonts.regular,
                    color: AppColors.primaryColor),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),
          const OrderStatusSection(),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          // List Tiles Section
          SizedBox(
            height: screenWidth * .3,
            width: screenWidth,
            child: ListTile(
              onTap: () {
                AppNavigation.navigation(
                  context,OrderListScreen()
                );
              },
              leading: Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(
                          AppAssets.grocery,
                        ),
                        fit: BoxFit.cover)),
              ),
              title: Text(
                'Paropkar Shop',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              subtitle: Text(
                'daily need su...',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: AppFonts.regular,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.primaryColor),
              ),
              trailing: SizedBox(
                width: screenWidth * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconImage(
                      onPress: () {},
                      icon: const Icon(
                        Icons.call,
                        size: 18,
                      ),
                      backgroundColor: AppColors.greenLight.withOpacity(.3),
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomIconImage(
                      onPress: () {},
                      backgroundColor: AppColors.greenLight.withOpacity(.3),
                      icon: const Icon(
                        Icons.message,
                        size: 18,
                      ),
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderStatusSection extends StatefulWidget {
  const OrderStatusSection({super.key});

  @override
  State<OrderStatusSection> createState() => _OrderStatusSectionState();
}

class _OrderStatusSectionState extends State<OrderStatusSection> {
  int _currentStatus = 0; // 0: Accepted, 1: Picked Up, 2: Delivered

  void _changeStatus() {
    setState(() {
      _currentStatus++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * .05,
            right: screenWidth * .05,
          ),
          child: const Row(
            children: [
              OrderStatusIcon(
                isSuccess: true,
              ),
              OrderStatusProgressLinear(
                isSuccess: true,
              ),
              OrderStatusIcon(
                isSuccess: false,
              ),
              OrderStatusProgressLinear(
                isSuccess: false,
              ),
              OrderStatusIcon(
                isSuccess: false,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * .05,
            right: screenWidth * .05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Accept',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                      )),
              Text("Pickup",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                      )),
              Text("Delivered",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                      ))
            ],
          ),
        ),
        _buildDeliveryPersonInfo(),
      ],
    );
  }

  Widget _buildStatusText() {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      style: TextStyle(),
      child: Text(
        _getStatusText(_currentStatus),
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: _currentStatus / 2, // Adjust value based on status
    );
  }

  Widget _buildDeliveryPersonInfo() {
    // Implement your delivery person information here
    return Row(
      children: [
        // Image of delivery person
        // Delivery person name
      ],
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Accepted';
      case 1:
        return 'Picked Up';
      case 2:
        return 'Delivered';
      default:
        return '';
    }
  }
}

class OrderStatusProgressLinear extends StatelessWidget {
  const OrderStatusProgressLinear({
    super.key,
    required this.isSuccess,
  });
  final bool isSuccess;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          width: screenWidth * .4,
          child: LinearProgressIndicator(
            value: 1,
            color: isSuccess ? AppColors.primaryColor : AppColors.grey,
          )),
    );
  }
}

class OrderStatusIcon extends StatelessWidget {
  const OrderStatusIcon({
    super.key,
    required this.isSuccess,
  });
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth * .07,
      width: screenWidth * .07,
      decoration:
          BoxDecoration(color: AppColors.primaryColor, shape: BoxShape.circle),
      child: Icon(
        isSuccess ? Icons.check : Icons.circle,
        size: isSuccess ? null : 18,
        color: Theme.of(context).cardColor,
      ),
    );
  }
}
