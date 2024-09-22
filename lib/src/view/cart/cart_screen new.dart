import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/bloc_provider/Cart/Cart_event.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_bloc.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_state.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/textfields/custom_textfied.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// Colors for the theme
const primaryColor =
    Color(0xFF00A55B); // Example primary color (adjust as per design)
const greyColor = Color(0xFF757575); // Example grey color for text
const whiteColor = Color(0xFFFFFFFF); // Example white background

// Main Cart Screen
class CartScreenNew extends StatelessWidget {
  CartScreenNew({super.key});

  // final bottomBarListController = BottomBarListController();
  @override
  Widget build(BuildContext context) {
    final bottomController = Provider.of<BottomBarListController>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
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
            onPress: () {
              bottomController.changeIndex(0);
            },
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
          'Cart',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 20,
              fontFamily: AppFonts.semiBold,
              color: Theme.of(context).canvasColor),
        ),
      ),

      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        DataStatus dataStatus = state is CartLoading
            ? DataStatus.loading
            : state is CartSuccess
                ? DataStatus.success
                : DataStatus.error;
        bool isDataEmpty = (state is CartSuccess) &&
            ((state.cartData.data == null) || state.cartData.data!.isEmpty);
        return DataStateWidget(
          isOverlay: false,
          ontapRetry: () {
            context.read<CartBloc>().add(FetchCart());
          },
          status: dataStatus,
          isDataEmpty: isDataEmpty,
          child: state is CartSuccess
              ? SizedBox(
                  height: screenHeight,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, top: 12, right: 12),
                          child: Column(
                            children: [
                              Column(
                                  children: List.generate(
                                      state.cartData.data!.length, (index) {
                                final cart = state.cartData.data![index];
                                // print(controller.cartItemList[index].quantity);
                                return cart.product == null
                                    ? const SizedBox()
                                    : CartItem(
                                        title: formatData(cart.product!.name),
                                        category: formatData(
                                            cart.product!.description),
                                        price: formatData(cart.product!.price),
                                        quantity: formatData(cart.quantity),
                                        onChange: (String value) {},
                                        onIncrease: () async {
                                          // await controller.onIncreaseProduct(
                                          //   index: index,
                                          //   product_id:
                                          //       formatData(cart.product!.id),
                                          //   variation_id:
                                          //       cart.variationId!.toString(),
                                          //   quantity: 1,
                                          //   context: context,
                                          // );
                                          // await controller.getCarts();
                                        },
                                        onDecrease: () async {
                                          // controller.onDecreaseProduct(
                                          //   index: index,
                                          //   product_id:
                                          //       formatData(cart.product!.id),
                                          //   variation_id:
                                          //       cart.variationId!.toString(),
                                          //   quantity: 1,
                                          //   context: context,
                                          // );
                                        },
                                        onSubmitted: (String value) async {
                                          // await controller
                                          //     .changeProductQuantity(
                                          //   index: index,
                                          //   product_id:
                                          //       formatData(cart.product!.id),
                                          //   variation_id:
                                          //       cart.variationId!.toString(),
                                          //   quantity: cart.product!.stock!,
                                          //   context: context,
                                          // );
                                          // ignore: use_build_context_synchronously
                                          context
                                              .read<CartBloc>()
                                              .add(FetchCart());
                                        },
                                      );
                              })),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: whiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 50,
                                        child: CustomTextFormWidget(
                                          controller: TextEditingController(),
                                          contentpadding:
                                              const EdgeInsets.only(left: 20),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(40)),
                                          fillColor: AppColors.primaryColor
                                              .withOpacity(.1),
                                          hintText: "Enter code",
                                          validator: (String? value) {
                                            return null;
                                          },
                                          suffixWidget: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomButton(
                                              text: 'Apply',
                                              height: 40,
                                              width: 70,
                                              borderRadius: 39,
                                              ontap: () {},
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Sub Total',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        Text('₹ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Delivery Charges',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        Text('₹ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Discount',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: Colors.red)),
                                        Text('- ₹ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total Price',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                        Text('₹ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                      // Expanded(child: SizedBox(height: 10,)),
                      Positioned(
                        bottom: 0,
                        child: SizedBox(
                          height: screenWidth * .3,
                          child: CheckoutButton(
                            total: 850.00,
                            // onPressed: () {},
                            onPressed: () {},
                            text: 'Continue',
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : null,
        );
      }),
      // bottomNavigationBar: SizedBox(
      //   height: screenWidth * .3,
      //   child: CheckoutButton(
      //     total: 850.00,
      //     // onPressed: () {},
      //     onPressed: () {
      //       controller.ontapContinueButton(context);
      //     },
      //     text: 'Continue',
      //   ),
      // ),
    );
  }
}

// Custom Cart Item Widget
class CartItem extends StatefulWidget {
  final String title;
  final String category;
  final String price;
  final String quantity;
  final Function(String value) onChange;
  final Function() onIncrease;
  final Function() onDecrease;
  final Function(String value) onSubmitted;

  const CartItem({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.quantity,
    required this.onChange,
    required this.onIncrease,
    required this.onDecrease,
    required this.onSubmitted,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _isEditing = false;
  TextEditingController _controller =
      TextEditingController(text: '1'); // Initially "1"
  @override
  void initState() {
    _controller = TextEditingController(text: widget.quantity);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: screenWidth * .2,
            width: screenWidth * .2,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(AppAssets.maida),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ////////////
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: screenWidth * .4,
                  child: Text(
                    widget.category,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppFonts.regular),
                    maxLines: 3,
                  ),
                ),
                Text(
                  '₹ ${widget.price}',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryColor,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 17,
                      fontFamily: AppFonts.semiBold),
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconImage(
                    elevation: 1,
                    spreadRadius: 0,
                    borderRadius: 3,
                    size: 27,
                    backgroundColor: AppColors.grey,
                    icon: const Icon(
                      Icons.remove,
                      size: 19,
                      color: AppColors.primaryColor,
                    ),
                    onPress: widget.onDecrease,
                  ),

                  ///first code
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10, right: 10),
                  //   child: Text(
                  //     ' 1 ',
                  //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  //         color: AppColors.primaryColor,
                  //         overflow: TextOverflow.ellipsis,
                  //         fontFamily: AppFonts.semiBold,
                  //         fontSize: 15),
                  //   ),
                  // ),

                  //after code
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      child: _isEditing
                          ? SizedBox(
                              width: 50, // Small width for the text field
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _controller,
                                autofocus:
                                    true, // Automatically focuses the text field
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18), // Adjust font size as needed
                                decoration: const InputDecoration(
                                    counterText: '',
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                                cursorColor: AppColors.primaryColor,
                                onSubmitted: (newValue) {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                  widget.onSubmitted(newValue);
                                },
                                onChanged: widget.onChange,
                                maxLength: 3,
                              ),
                            )
                          : SizedBox(
                              width: 60, // Small width for the text field
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    widget.quantity,
                                    style: const TextStyle(
                                        fontSize: 18), // Adjust the font size
                                  ),
                                ),
                              ),
                            )),
                  CustomIconImage(
                    spreadRadius: 0,
                    borderRadius: 0,
                    size: 27,
                    backgroundColor: AppColors.primaryColor,
                    icon: Icon(
                      Icons.add,
                      size: 19,
                      color: Theme.of(context).cardColor,
                    ),
                    onPress: widget.onIncrease,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Checkout Button Widget
class CheckoutButton extends StatelessWidget {
  final double total;
  final String text;
  final VoidCallback onPressed;

  const CheckoutButton(
      {super.key,
      required this.total,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 5, // Spread radius (increase size of shadow)
            blurRadius: 7, // Blur radius (smooth the edges of shadow)
            offset: Offset(0, 3), // Position of shadow (x,y)
          ),
        ],
      ),

      // height: screenHeight * .1,
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.primaryColor)),
              SizedBox(
                width: screenWidth * .34,
                child: Text('₹ $total',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontFamily: AppFonts.semiBold,
                        overflow: TextOverflow.ellipsis)),
              ),
            ],
          ),
          CustomButton(
            width: screenWidth * .5,
            text: text,
            ontap: onPressed,
          )
        ],
      ),
    );
  }
}