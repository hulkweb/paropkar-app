import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/custom_network_image.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/models/cart/cart_model.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key, this.categoryName, this.category_id});
  final String? categoryName;
  final String? category_id;
  @override
  Widget build(BuildContext context) {
    // final bottomController = Provider.of<BottomBarListController>(context);
    final cartController = Provider.of<CartController>(context, listen: true);
    final favoriteController =
        Provider.of<FavoriteController>(context, listen: true);
    final bottomBarController = Provider.of<BottomBarListController>(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primaryColor,
              expandedHeight: 70.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  color: AppColors.primaryColor, // Set the color here
                ),
                titlePadding: const EdgeInsets.only(top: 30),
                expandedTitleScale: 1,
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          pop(context);
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      ////
                      SizedBox(
                        width: 150,
                        child: Text(categoryName ?? '',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.white),
                            overflow: TextOverflow.ellipsis),
                      ),

                      IconButton(
                        onPressed: () {
                          AppNavigation.navigationPush(
                              context, NotificationScreen());
                        },
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Consumer<ProductListingController>(
            builder: (context, controller, state) {
          return DataStateWidget(
            status: controller.productDataStatus,
            ontapRetry: () {
              controller.getProducts();
            },
            isOverlay: cartController.addCartDataStatus == DataStatus.loading ||
                favoriteController.addFavoriteDataStatus == DataStatus.loading,
            // isDataEmpty:  (controller.productListData!.data != null) &&
            //         (controller.productListData!.data!.data!.isEmpty),
            isDataEmpty: controller.productDataStatus == DataStatus.success &&
                controller.productsData!.data == null,
            child: controller.productDataStatus == DataStatus.success
                ? GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(screenWidth * .04),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6,
                    children: controller.productsData!.data == null
                        ? []
                        : List.generate(
                            controller.productsData!.data!.data!.length,
                            (index) {
                              final product =
                                  controller.productsData!.data!.data![index];
                              return ProductCard(
                                imageUrl: product.image ??
                                    '', // AppAssets.maida, // Replace with actual image URL
                                productName: product.name ?? '',
                                price: "₹${product.price ?? ''}",
                                categoryName: product.category == null
                                    ? ""
                                    : product.category!.name ??
                                        '', //"Buy 3 Items, Save Extra 5%",
                                isFavorite: product.isFavorite ?? false,
                                onFavoritePressed: () {
                                  favoriteController.addRemoveFavorite(
                                      product_id: product.id.toString(),
                                      context: context);
                                },
                                // onAddToCartPressed: () {
                                //   List<Variation> variationList =
                                //       []; // controller.productsData?.data?.data?[index].variations;
                                //   for (int i = 0;
                                //       i <
                                //           (controller
                                //                   .productsData
                                //                   ?.data
                                //                   ?.data?[index]
                                //                   .variations
                                //                   ?.length ??
                                //               0);
                                //       i++) {
                                //     final instance = controller.productsData
                                //         ?.data?.data?[index].variations?[i];
                                //     Variation variation = Variation(
                                //         id: instance?.id,
                                //         image: instance?.image,
                                //         color: instance?.color,
                                //         variationName: instance?.variationName);
                                //     variationList.add(variation);
                                //   }
                                //   showVariationDialog(context, variationList, ontapOk: (String variationId, String quantity) {

                                //    });
                                // },
                                onAddToCartPressed: () async {
                                  if (!(product.isCart ?? false)) {
                                    List<Variation> variationList =
                                        []; // controller.productsData?.data?.data?[index].variations;
                                    for (int i = 0;
                                        i <
                                            (controller
                                                    .productsData
                                                    ?.data
                                                    ?.data?[index]
                                                    .variations
                                                    ?.length ??
                                                0);
                                        i++) {
                                      final instance = controller.productsData
                                          ?.data?.data?[index].variations?[i];
                                      Variation variation = Variation(
                                          id: instance?.id,
                                          image: instance?.image,
                                          color: instance?.color,
                                          variationName:
                                              instance?.variationName);
                                      variationList.add(variation);
                                    }
                                    showVariationDialog(context, variationList,
                                        ontapOk: (String variationId,
                                            String quantity) async {
                                      await cartController.addCart(
                                          variation_id: variationId,
                                          product_id: product.id.toString(),
                                          quantity: quantity,
                                          context: context);
                                      await controller.getProducts(
                                          category_id: category_id ?? '',
                                          loading: false);
                                    });
                                  } else {
                                    AppNavigation.pushAndRemoveUntil(
                                        context, const BottomBarListScreen());
                                    bottomBarController.changeIndex(2);
                                  }
                                },
                                onProductPressed: () {
                                  context
                                      .read<ProductDetailController>()
                                      .changeQuantity(1);
                                  context
                                      .read<ProductDetailController>()
                                      .getProductDetail(
                                        context,
                                        id: '${product.id ?? ''}',
                                      );
                                  AppNavigation.navigationPush(
                                      context,
                                      ProductDetailScreen(
                                        id: '${product.id ?? ''}',
                                        categoryId:
                                            '${product.categoryId ?? ''}',
                                        subcategoryId:
                                            '${product.subcategoryId ?? ''}',
                                      ));
                                },
                                isCartAdded: product.isCart ?? false,
                              );
                            },
                          ))
                : const SizedBox(),
          );
        }),
      ),
    );
  }
}

Future<Map<String, dynamic>?> showVariationDialog(
    BuildContext context, List<Variation> variations,
    {required Function(String variationId, String quantity) ontapOk}) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      String? selectedVariationId;
      int selectedQuantity = 1;
      return AlertDialog(
        actionsPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.only(left: 20),
        title: const Text('Select a Variation'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: screenWidth * .4,
              height: screenWidth * .45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * .4,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: variations.map((variation) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            selectedVariationId = variation.id.toString();
                            setState;
                            if (kDebugMode) {
                              print('setted');
                              print(selectedVariationId);
                              print(variation.id.toString());
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: (selectedVariationId ==
                                            variation.id.toString())
                                        ? AppColors.primaryColor
                                        : Colors.transparent)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomNetworkImage(
                                  imageUrl: variation.image ?? '',
                                  height: 40,
                                  width: 40,
                                ),
                                smallHeight,
                                SizedBox(
                                    width: screenWidth * .15,
                                    child: Text(variation.variationName ?? '')),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  smallHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconImage(
                          onPress: () {
                            if (selectedQuantity > 1) selectedQuantity--;
                            setState(
                              () {},
                            );
                          },
                          icon: const Icon(Icons.remove)),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "$selectedQuantity",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      CustomIconImage(
                          onPress: () {
                            selectedQuantity++;
                            setState(
                              () {},
                            );
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  )
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (selectedVariationId != null && selectedQuantity != null) {
                Navigator.of(context).pop();
                ontapOk(selectedVariationId!, selectedQuantity.toString());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Please select a variation and quantity')),
                );
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
