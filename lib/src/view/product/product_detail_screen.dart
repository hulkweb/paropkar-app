// ignore_for_file: unused_import

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
import 'package:paropkar/src/view/product/product_listing_screen.dart';
import 'package:paropkar/src/custom_widgets/carousel_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreenNew extends StatelessWidget {
  ProductDetailScreenNew(
      {super.key,
      required this.id,
      required this.categoryId,
      required this.subcategoryId});
  final String id;
  final String categoryId;
  final String subcategoryId;
  final productDetailController = ProductDetailController();
  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context, listen: true);
    final favoriteController =
        Provider.of<FavoriteController>(context, listen: true);
    final bottomBarController = Provider.of<BottomBarListController>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Consumer<ProductDetailController>(
                builder: (context, controller, state) {
              return Builder(builder: (context) {
                return DataStateWidget(
                  status: controller.productDetailDataStatus,
                  ontapRetry: () {
                    context.read<ProductDetailController>().getProductDetail(
                          context,
                          id: id,
                        );
                  },
                  isDataEmpty: controller.productDetailDataStatus ==
                          DataStatus.success &&
                      (controller.productDetailData == null ||
                          controller.productDetailData!.data == null),
                  child: controller.productDetailDataStatus ==
                              DataStatus.success &&
                          (controller.productDetailData == null ||
                              controller.productDetailData!.data == null)
                      ? const SizedBox()
                      : controller.productDetailDataStatus == DataStatus.success
                          ? SizedBox(
                              height: screenHeight,
                              width: screenWidth,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: screenHeight * .4,
                                      width: screenWidth,
                                      color: AppColors.primaryColor
                                          .withOpacity(.1),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: ListView(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, bottom: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Details',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: screenWidth*.1,right: screenWidth*.1),
                                              child: CustomNetworkImage(
                                                imageUrl: controller
                                                        .productDetailData
                                                        ?.data
                                                        ?.product
                                                        ?.image ??
                                                    '',
                                                height: screenHeight * .25,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * .05,
                                          right: screenWidth * .05),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.productDetailData
                                                        ?.data?.product?.name ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: List.generate(
                                                    5,
                                                    (index) => const Icon(
                                                          Icons.star,
                                                          color: AppColors
                                                              .primaryColor,
                                                        )),
                                              ),
                                              Text(
                                                "Buy 10kg, save extra 5% local",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        fontFamily:
                                                            AppFonts.light,
                                                        fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: '₹ ',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: controller
                                                              .productDetailData
                                                              ?.data
                                                              ?.product
                                                              ?.price ??
                                                          '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontFamily:
                                                                  AppFonts
                                                                      .semiBold,
                                                              fontSize: 20),
                                                    ),
                                                    const TextSpan(
                                                      text: '/kg',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (controller.productDetailData
                                                      ?.data?.product?.isCart !=
                                                  null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0),
                                                  child: Consumer<
                                                          ProductDetailController>(
                                                      builder: (context,
                                                          controller, child) {
                                                    print(
                                                        'condition ${(controller.productDetailData!.data!.product!.isCart!)}');
                                                    return !(controller
                                                                .productDetailData
                                                                ?.data
                                                                ?.product
                                                                ?.isCart ??
                                                            false)
                                                        ? CustomButton(
                                                            loading:
                                                                const SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child: CupertinoActivityIndicator(
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  radius: 10.0,
                                                                  animating:
                                                                      true),
                                                            ),
                                                            isLoading: cartController
                                                                    .addCartDataStatus ==
                                                                DataStatus
                                                                    .loading,
                                                            width: screenWidth *
                                                                .3,
                                                            height:
                                                                screenHeight *
                                                                    .05,
                                                            text: 'Add to cart',
                                                            ontap: () async {
                                                              await cartController.addCart(
                                                                  product_id: controller
                                                                      .productDetailData!
                                                                      .data!
                                                                      .product!
                                                                      .id
                                                                      .toString(),
                                                                  quantity: '1',
                                                                  variation_id: controller
                                                                      .productDetailData!
                                                                      .data!
                                                                      .product!
                                                                      .variations![
                                                                          0]
                                                                      .id
                                                                      .toString(),
                                                                  context:
                                                                      context);
                                                              await controller
                                                                  .getProductDetail(
                                                                      context,
                                                                      id: id);
                                                            },
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  CustomIconImage(
                                                                    elevation:
                                                                        1,
                                                                    spreadRadius:
                                                                        0,
                                                                    borderRadius:
                                                                        3,
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .grey,
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                    ),
                                                                    onPress:
                                                                        () {
                                                                      productDetailController
                                                                          .ontapProductIncrease();
                                                                    },
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        '1',
                                                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontFamily: AppFonts.semiBold,
                                                                            fontSize: 20),
                                                                      ),
                                                                    );
                                                                  }),
                                                                  CustomIconImage(
                                                                    spreadRadius:
                                                                        0,
                                                                    borderRadius:
                                                                        0,
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .primaryColor,
                                                                    icon: Icon(
                                                                      Icons.add,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .cardColor,
                                                                    ),
                                                                    onPress:
                                                                        () {},
                                                                  ),
                                                                ],
                                                              ),
                                                              mediumHeight,
                                                              CustomButton(
                                                                width:
                                                                    screenWidth *
                                                                        .25,
                                                                height:
                                                                    screenHeight *
                                                                        .04,
                                                                text:
                                                                    'View to cart',
                                                                textAppTextStyles: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelSmall!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .white),
                                                                ontap:
                                                                    () async {
                                                                  AppNavigation
                                                                      .pushAndRemoveUntil(
                                                                          context,
                                                                          const BottomBarListScreen());
                                                                  bottomBarController
                                                                      .changeIndex(
                                                                          2);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                  }),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Product Details',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            AppFonts.semiBold),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: screenWidth * .8,
                                                  child: Text(
                                                    controller
                                                            .productDetailData!
                                                            .data
                                                            ?.product
                                                            ?.description ??
                                                        '', //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ultricies et elit quis interdum. Aenean eleifend odio non urna blandit lobortis. Nulla commodo felis at orci mattis, at maximus ante congue.',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              AppFonts.regular,
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                    maxLines: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Related Products',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            AppFonts.semiBold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    GridView.count(
                                        crossAxisCount: 2,
                                        padding:
                                            EdgeInsets.all(screenWidth * .04),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisSpacing: 7,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.7,
                                        children: List.generate(
                                          controller.productDetailData!.data!
                                                  .relatedProducts?.length ??
                                              0,
                                          (index) {
                                            final product = controller
                                                .productDetailData
                                                ?.data
                                                ?.relatedProducts?[index];
                                            return ProductCard(
                                              imageUrl: product!.image ??
                                                  '', // AppAssets.maida, // Replace with actual image URL
                                              productName: product.name ?? '',
                                              price: "₹${product.price ?? ''}",
                                              categoryName:
                                                  'cat', //"Buy 3 Items, Save Extra 5%",
                                              isFavorite:
                                                  product.isFavorite ?? false,
                                              onFavoritePressed: () async {
                                                await favoriteController
                                                    .addRemoveFavorite(
                                                        product_id: product.id
                                                            .toString(),
                                                        context: context);
                                                controller.getProductDetail(
                                                    context,
                                                    id: id);
                                              },
                                              onAddToCartPressed: () async {
                                                if (!(product.isCart ??
                                                    false)) {
                                                  await cartController.addCart(
                                                      variation_id: product
                                                          .variations![0].id
                                                          .toString(),
                                                      product_id:
                                                          product.id.toString(),
                                                      quantity: "1",
                                                      context: context);
                                                  await controller
                                                      .getProductDetail(context,
                                                          loading: false,
                                                          id: id);
                                                } else {
                                                  AppNavigation
                                                      .pushAndRemoveUntil(
                                                          context,
                                                          BottomBarListScreen());
                                                  bottomBarController
                                                      .changeIndex(2);
                                                }
                                              },
                                              onProductPressed: () {
                                                context
                                                    .read<
                                                        ProductDetailController>()
                                                    .getProductDetail(
                                                      context,
                                                      id: '${product.id ?? ''}',
                                                      loading: false,
                                                    );
                                                AppNavigation.navigationPush(
                                                    context,
                                                    ProductDetailScreenNew(
                                                      id: '${product.id ?? ''}',
                                                      categoryId:
                                                          '${product.categoryId ?? ''}',
                                                      subcategoryId:
                                                          '${product.subcategoryId ?? ''}',
                                                    ));
                                              },
                                              isCartAdded:
                                                  product.isCart ?? false,
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            )
                          : null,
                );
              });
            }),
            Positioned(
              top: 40,
              left: 30,
              child: CustomIconImage(
                icon: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  ),
                ),
                onPress: () {
                  pop(context);
                },
              ),
            ),
            Positioned(
              top: 40,
              right: 30,
              child: Consumer<ProductDetailController>(
                  builder: (context, controller, child) {
                return CustomIconImage(
                  icon: const Icon(
                    Icons.notifications,
                    color: AppColors.primaryColor,
                    size: 23,
                  ),
                  onPress: () {
                    AppNavigation.navigationPush(context, NotificationScreen());
                  },
                );
              }),
            )
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
          Text(name, style: Theme.of(context).textTheme.bodyLarge),
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
