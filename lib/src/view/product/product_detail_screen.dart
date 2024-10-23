// ignore_for_file: unused_import, unnecessary_import, depend_on_referenced_packages, unused_local_variable, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/bloc_provider/product/product_block.dart';
import 'package:paropkar/src/bloc_provider/product/product_event.dart';
import 'package:paropkar/src/bloc_provider/product/product_state.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_network_image.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/cart/cart_screen%20new.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/view/product/product_listing_screen.dart';
import 'package:paropkar/src/custom_widgets/carousel_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key,
      required this.id,
      required this.categoryId,
      required this.subcategoryId});
  final String id;
  final String categoryId;
  final String subcategoryId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProductDetailController>().changeAddedProductDetail(VariationAddition());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productDetailController = context.read<ProductDetailController>();
    final favoriteController = Provider.of<FavoriteController>(context);
    final cartController = Provider.of<CartController>(context);
    final bottomBarController = Provider.of<BottomBarListController>(context);
    return SafeArea(
        child: Scaffold(
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
              Navigator.pop(context);
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
              onPress: () {
                AppNavigation.navigationPush(context, NotificationScreen());
              },
            ),
          ),
        ],
        title: Text(
          'Detail',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.white),
        ),
      ),
      body: Consumer<ProductDetailController>(
          builder: (context, controller, state) {
        return DataStateWidget(
            status: controller.productDetailDataStatus,
            ontapRetry: () {
              controller.getProductDetail(context, id: widget.id);
            },
            isOverlay: cartController.addCartDataStatus == DataStatus.loading ||
                favoriteController.addFavoriteDataStatus == DataStatus.loading,
            // isDataEmpty:  (controller.productListData!.data != null) &&
            //         (controller.productListData!.data!.data!.isEmpty),
            isDataEmpty:
                controller.productDetailDataStatus == DataStatus.success &&
                    controller.productDetailData!.data == null,
            child: controller.productDetailDataStatus == DataStatus.success
                ? ListView(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight * .04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          smallWidth,
                          CustomNetworkImage(
                            imageUrl: productDetailController
                                    .productDetailData?.data?.product?.image ??
                                '',
                            height: screenWidth * .27,
                            width: screenWidth * .27,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: screenWidth * .6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productDetailController.productDetailData
                                            ?.data?.product?.name ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  smallHeight,
                                  Builder(builder: (context) {
                                    String priceText = '';
                                    double price = double.parse(
                                        productDetailController
                                                .productDetailData
                                                ?.data
                                                ?.product
                                                ?.price ??
                                            '0.0');
                                    double discountValue = double.parse(
                                        productDetailController
                                                .productDetailData
                                                ?.data
                                                ?.product
                                                ?.discountValue ??
                                            '0.0');
                                    String discountPrice = '';
                                    String discountType =
                                        productDetailController
                                                .productDetailData
                                                ?.data
                                                ?.product
                                                ?.discountType ??
                                            '';
                                    if ((discountType) == 'percentage') {
                                      discountPrice =
                                          ((price * discountValue) / 100)
                                              .toString();
                                    } else {
                                      discountPrice = discountValue.toString();
                                    }
                                    String finalPrice =
                                        (price - double.parse(discountPrice))
                                            .toString();
                                    return RichText(
                                      text: TextSpan(
                                          text: '₹${finalPrice}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!,
                                          children: [
                                            TextSpan(
                                              text:
                                                  ' MRP:₹${productDetailController.productDetailData?.data?.product?.price ?? ''}',
                                              style: const TextStyle(
                                                color: AppColors.grey,
                                              ),
                                            ),
                                          ]),
                                    );
                                  }),
                                  smallHeight,
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Builder(builder: (context) {
                                        String priceText = '';
                                        double price = double.parse(
                                            productDetailController
                                                    .productDetailData
                                                    ?.data
                                                    ?.product
                                                    ?.price ??
                                                '0.0');
                                        double discountValue = double.parse(
                                            productDetailController
                                                    .productDetailData
                                                    ?.data
                                                    ?.product
                                                    ?.discountValue ??
                                                '0.0');
                                        String discountPrice = '';
                                        String discountType =
                                            productDetailController
                                                    .productDetailData
                                                    ?.data
                                                    ?.product
                                                    ?.discountType ??
                                                '';
                                        if ((discountType) == 'percentage') {
                                          discountPrice =
                                              ((price * discountValue) / 100)
                                                  .toString();
                                        } else {
                                          discountPrice =
                                              discountValue.toString();
                                        }
                                        return Text(
                                          ((discountType) == 'percentage')
                                              // ignore: unnecessary_brace_in_string_interps
                                              ? 'Margin:₹${discountPrice} off | ${discountValue}%'
                                              : 'Margin:₹${discountPrice} off',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                        );
                                      })),
                                ],
                              ),
                            ),
                          ),
                          smallWidth
                        ],
                      ),
                      mediumHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            '1 Offer',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.primaryColor),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      smallHeight,
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * .05),
                        child: Row(
                          children: [
                            const DataBox(
                              quntity: 'Quantity',
                              price: '	Price in ₹',
                              margin: 'Margin in %',
                              isSelected: false,
                              borderColor: AppColors.primaryColor,
                            ),
                            smallWidth,
                            Consumer<ProductDetailController>(
                                builder: (context, controller, child) {
                              return Expanded(
                                child: SizedBox(
                                  width: screenWidth * .7,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, right: 6),
                                      child: Builder(builder: (context) {
                                        return Row(
                                          children: List.generate(
                                            controller
                                                    .productDetailData
                                                    ?.data
                                                    ?.product
                                                    ?.variations
                                                    ?.length ??
                                                0,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: InkWell(
                                                onTap: () {
                                                  controller.changeAddedProductDetail(
                                                      VariationAddition(
                                                          id: controller
                                                              .productDetailData
                                                              ?.data
                                                              ?.product
                                                              ?.variations?[
                                                                  index]
                                                              .id,
                                                          toQty: controller
                                                              .productDetailData
                                                              ?.data
                                                              ?.product
                                                              ?.variations?[
                                                                  index]
                                                              .toQty,
                                                          fromQty: controller
                                                              .productDetailData
                                                              ?.data
                                                              ?.product
                                                              ?.variations?[
                                                                  index]
                                                              .fromQty));
                                                  productDetailController
                                                      .changeQuantity(int.parse(
                                                          controller
                                                                  .productDetailData
                                                                  ?.data
                                                                  ?.product
                                                                  ?.variations?[
                                                                      index]
                                                                  .toQty ??
                                                              '1'));
                                                },
                                                child: DataBox(
                                                    borderColor:
                                                        AppColors.primaryColor,
                                                    quntity:
                                                        '${controller.productDetailData?.data?.product?.variations?[index].toQty ?? ''}${controller.productDetailData?.data?.product?.variations?[index].fromQty == '+' ? '' : '-'}${controller.productDetailData?.data?.product?.variations?[index].fromQty ?? ''}',
                                                    price:
                                                        '₹${controller.productDetailData?.data?.product?.variations?[index].price ?? ''}',
                                                    margin:
                                                        '${controller.productDetailData?.data?.product?.variations?[index].margin ?? ''}%',
                                                    // ignore: unnecessary_string_interpolations
                                                    isSelected: (controller
                                                                .addedVariationProductDetail
                                                                .id ??
                                                            0) ==
                                                        controller
                                                            .productDetailData
                                                            ?.data
                                                            ?.product
                                                            ?.variations?[index]
                                                            .id),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      mediumHeight,
                      Selector<ProductDetailController, int>(
                          selector: (context, controller) =>
                              controller.quantity,
                          builder: (context, quantity, child) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * .05,
                                  right: screenWidth * .05),
                              child: Builder(builder: (context) {
                                const color = AppColors.grey;
                                return Container(
                                  height: 50,
                                  width: screenWidth * .8,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: color,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  // padding: EdgeInsets.only(left: 40, right: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  int to_qty = int.parse(
                                                      productDetailController
                                                              .addedVariationProductDetail
                                                              .toQty ??
                                                          '1');
                                                  if (productDetailController
                                                          .quantity >
                                                      to_qty) {
                                                    productDetailController
                                                        .decrimentQuantity();
                                                  }
                                                },
                                                icon: const Icon(Icons.remove)),
                                          ),
                                          Container(
                                              height: 50,
                                              width: 2,
                                              color: color),
                                        ],
                                      ),
                                      Text(
                                        '${productDetailController.quantity}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 2,
                                              color: color),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  if (productDetailController
                                                          .addedVariationProductDetail
                                                          .fromQty ==
                                                      '+') {
                                                    productDetailController
                                                        .incrimentQuantity();
                                                  } else {
                                                    int from_qty = int.parse(
                                                        productDetailController
                                                                .addedVariationProductDetail
                                                                .fromQty ??
                                                            '1');

                                                    if (productDetailController
                                                            .quantity <
                                                        from_qty) {
                                                      productDetailController
                                                          .incrimentQuantity();
                                                    }
                                                  }
                                                },
                                                icon: const Icon(Icons.add)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          }),
                      smallHeight,
                      Builder(builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * .05,
                              right: screenWidth * .05),
                          child: CustomButton(
                            loading: const SizedBox(
                              height: 30,
                              width: 30,
                              child: CupertinoActivityIndicator(
                                  color: AppColors.white,
                                  radius: 10.0,
                                  animating: true),
                            ),
                            isLoading: productDetailController
                                    .productDetailDataStatus ==
                                DataStatus.loading,
                            width: screenWidth * .8,
                            height: screenHeight * .07,
                            buttonText: !(productDetailController
                                        .productDetailData
                                        ?.data
                                        ?.product
                                        ?.isCart ??
                                    false)
                                ? 'Add to cart'
                                : 'View to Cart',
                            ontap: () async {
                              if (!(productDetailController.productDetailData
                                      ?.data?.product?.isCart ??
                                  false)) {
                                if (productDetailController.addedVariationProductDetail.id ==
                                    null) {
                                  showToast(
                                      message: 'Select atleast 1 variation id');
                                  return;
                                } else {
                                  await cartController.addCart(
                                      product_id: productDetailController
                                          .productDetailData!.data!.product!.id
                                          .toString(),
                                      quantity: productDetailController.quantity
                                          .toString(),
                                      variation_id: productDetailController
                                              .addedVariationProductDetail.id
                                              ?.toString() ??
                                          '',
                                      context: context);
                                  await productDetailController
                                      .getProductDetail(context,
                                          id: widget.id, loading: false);
                                }
                              } else {
                                AppNavigation.pushAndRemoveUntil(
                                    context, BottomBarListScreen());
                                bottomBarController.changeIndex(2);
                              }
                            },
                          ),
                        );
                      }),
                      largeHeight,
                      if ((productDetailController.productDetailData?.data
                                  ?.relatedProducts?.length ??
                              0) !=
                          0)
                        const Divider(
                          color: AppColors.grey,
                        ),
                      largeHeight,
                      if ((productDetailController.productDetailData?.data
                                  ?.relatedProducts?.length ??
                              0) !=
                          0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            mediumWidth,
                            Text(
                              'Related Products',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontFamily: AppFonts.semiBold),
                            ),
                          ],
                        ),
                      Consumer<ProductDetailController>(
                          builder: (context, productDetailController, child) {
                        return GridView.count(
                            crossAxisCount: 2,
                            padding: EdgeInsets.all(screenWidth * .04),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                            children: List.generate(
                              productDetailController.productDetailData?.data
                                      ?.relatedProducts?.length ??
                                  0,
                              (index) {
                                print(productDetailController.productDetailData
                                    ?.data?.relatedProducts?.length);
                                final product = productDetailController
                                    .productDetailData
                                    ?.data
                                    ?.relatedProducts?[index];
                                return ProductCard(
                                  imageUrl: product?.image ??
                                      '', // AppAssets.maida, // Replace with actual image URL
                                  productName: product?.name ?? '',
                                  price: "₹${product?.price ?? ''}",
                                  categoryName:
                                      'cat', //"Buy 3 Items, Save Extra 5%",
                                  isFavorite: product?.isFavorite ?? false,
                                  onFavoritePressed: () async {
                                    await favoriteController.addRemoveFavorite(
                                        product_id: "${product?.id ?? 0}",
                                        context: context);
                                    productDetailController.getProductDetail(
                                        context,
                                        id: widget.id);
                                  },
                                  onAddToCartPressed: () async {
                                    if (!(product?.isCart ?? false)) {
                                      showVariationDialog(
                                        context,
                                        id:  product?.id?.toString(),
                                        onsuccess: (context) {
                                          productDetailController
                                              .getProductDetail(context,
                                                  id: widget.id,loading: false);
                                        },
                                      );
                                    } else {
                                      AppNavigation.pushAndRemoveUntil(
                                          context, BottomBarListScreen());
                                      bottomBarController.changeIndex(2);
                                    }
                                  },
                                  onProductPressed: () {
                                    context
                                        .read<ProductDetailController>()
                                        .getProductDetail(
                                          context,
                                          id: '${product?.id ?? ''}',
                                          loading: true,
                                        );
                                    Navigator.pop(context);
                                    AppNavigation.navigationPush(
                                        context,
                                        ProductDetailScreen(
                                          id: '${product?.id ?? ''}',
                                          categoryId:
                                              '${product?.categoryId ?? ''}',
                                          subcategoryId:
                                              '${product?.subcategoryId ?? ''}',
                                        ));
                                  },
                                  isCartAdded: product?.isCart ?? false,
                                );
                              },
                            ));
                      }),
                    ],
                  )
                : const SizedBox());
      }),
    ));
  }
}

class DataBox extends StatelessWidget {
  const DataBox(
      {super.key,
      required this.quntity,
      required this.price,
      required this.margin,
      this.quantityTextStyle,
      this.marginTextStyle,
      this.priceTextStyle,
      required this.isSelected,
      this.borderColor});
  final String quntity;
  final String price;
  final String margin;
  final TextStyle? quantityTextStyle;
  final TextStyle? marginTextStyle;
  final TextStyle? priceTextStyle;
  final bool isSelected;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.grey,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1, 3))
          ],
          color: isSelected
              ? AppColors.primaryColor.withOpacity(.4)
              : AppColors.white,
          border: Border.all(
              color: borderColor ?? const Color.fromARGB(255, 139, 111, 111))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quntity,
              style: quantityTextStyle ??
                  Theme.of(context).textTheme.bodyMedium!.copyWith(),
              textAlign: TextAlign.start,
            ),
            smallHeight,
            Text(
              price,
              style: marginTextStyle ??
                  Theme.of(context).textTheme.bodyMedium!.copyWith(),
              textAlign: TextAlign.start,
            ),
            smallHeight,
            Text(
              margin,
              style: priceTextStyle ??
                  Theme.of(context).textTheme.bodyMedium!.copyWith(),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

// Category Item Widget
class CategoryItem extends StatelessWidget {
  final String name;
  final String imagePath;

  const CategoryItem({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: screenWidth * .3,
          height: screenWidth * .3,
          decoration: BoxDecoration(
            color: Color(0xffFFFBF0),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2), offset: Offset(1, 1))
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(name),
      ],
    );
  }
}

// Popular Item Widget
class PopularItem extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const PopularItem(
      {required this.name, required this.price, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 5),
          Text(price, style: Theme.of(context).textTheme.bodyMedium),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: Icon(Icons.add_circle, color: Colors.green),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
