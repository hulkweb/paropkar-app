import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/custom_button.dart';
import 'package:paropkar/src/custom_widgets/custom_image_icon.dart';
import 'package:paropkar/src/custom_widgets/custom_network_image.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/custom_widgets/small_widgets.dart';
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
                                    showVariationDialog(
                                      context,
                                      id: controller.productsData?.data
                                              ?.data?[index].id
                                              ?.toString() ??
                                          '',
                                      onsuccess: (context) {
                                        controller.getProducts(
                                            category_id: category_id ?? '',
                                            loading: false);
                                      },
                                    );
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

Future<Map<String, dynamic>?> showVariationDialog(BuildContext context,
    {String? id, Function(BuildContext context)? onsuccess}) {
  context.read<ProductDetailController>().getProductDetail(context,
      id: id ?? '', loading: false, isVariationGet: true);
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (context) {
      return Dialog(
          alignment: Alignment.center,
          backgroundColor: AppColors.white,
          insetPadding: const EdgeInsets.only(left: 10, right: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
                alignment: Alignment.center,
                height: screenHeight * .45,
                width: screenWidth * .95,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: SizedBox(
                  height: screenHeight * .45,
                  width: screenWidth * .95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          mediumWidth,
                          Text('Variations',
                              style: Theme.of(context).textTheme.titleLarge),
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
                                                    .productDetailVariationData
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
                                                  controller.changeAddedVariation(
                                                      VariationAddition(
                                                          id: controller
                                                              .productDetailVariationData
                                                              ?.data
                                                              ?.product
                                                              ?.variations?[
                                                                  index]
                                                              .id,
                                                          toQty: controller
                                                              .productDetailVariationData
                                                              ?.data
                                                              ?.product
                                                              ?.variations?[
                                                                  index]
                                                              .toQty,
                                                          fromQty: controller
                                                              .productDetailVariationData
                                                              ?.data
                                                              ?.product
                                                              ?.variations?[
                                                                  index]
                                                              .fromQty));
                                                  controller.changeQuantity(
                                                      int.parse(controller
                                                              .productDetailVariationData
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
                                                        '${controller.productDetailVariationData?.data?.product?.variations?[index].toQty ?? ''}${controller.productDetailVariationData?.data?.product?.variations?[index].fromQty == '+' ? '' : '-'}${controller.productDetailVariationData?.data?.product?.variations?[index].fromQty ?? ''}',
                                                    price:
                                                        '₹${controller.productDetailVariationData?.data?.product?.variations?[index].price ?? ''}',
                                                    margin:
                                                        '${controller.productDetailVariationData?.data?.product?.variations?[index].margin ?? ''}%',
                                                    // ignore: unnecessary_string_interpolations
                                                    isSelected: (controller
                                                                .addedVariationVariatioin
                                                                .id ??
                                                            0) ==
                                                        controller
                                                            .productDetailVariationData
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
                      Consumer<ProductDetailController>(
                          builder: (context, controller, child) {
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
                                              int toQty = int.parse(controller
                                                      .addedVariationVariatioin
                                                      .toQty ??
                                                  '1');
                                              if (controller.quantity > toQty) {
                                                controller.decrimentQuantity();
                                              }
                                            },
                                            icon: const Icon(Icons.remove)),
                                      ),
                                      Container(
                                          height: 50, width: 2, color: color),
                                    ],
                                  ),
                                  Text(
                                    '${controller.quantity}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          height: 50, width: 2, color: color),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              if (controller
                                                      .addedVariationVariatioin
                                                      .fromQty ==
                                                  '+') {
                                                controller.incrimentQuantity();
                                              } else {
                                                int fromQty = int.parse(controller
                                                        .addedVariationVariatioin
                                                        .fromQty ??
                                                    '1');

                                                if (controller.quantity <
                                                    fromQty) {
                                                  controller
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
                      mediumHeight,
                      Consumer<ProductDetailController>(
                          builder: (context, controller, child) {
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
                            // isLoading: productDetailController
                            //         .productDetailDataStatus ==
                            //     DataStatus.loading,
                            isLoading: false,
                            width: screenWidth * .8,
                            height: screenHeight * .07,
                            buttonText: 'Add to cart',
                            ontap: () async {
                              if (!(controller.productDetailVariationData?.data
                                      ?.product?.isCart ??
                                  false)) {
                                if (controller.addedVariationVariatioin.id ==
                                    null) {
                                  showToast(
                                      message: 'Select atleast 1 variation id');
                                  return;
                                } else {
                                  Navigator.of(context).pop({
                                    'key':
                                        'value', // Return some Map<String, dynamic> when closing the dialog
                                  });
                                  await context.read<CartController>().addCart(
                                      product_id: controller
                                          .productDetailVariationData!
                                          .data!
                                          .product!
                                          .id
                                          .toString(),
                                      quantity: controller.quantity.toString(),
                                      variation_id: controller
                                              .addedVariationVariatioin.id
                                              ?.toString() ??
                                          '',
                                      context: context);
                                }
                                // ignore: use_build_context_synchronously

                                controller
                                    .changeAddedVariation(VariationAddition());
                                // ignore: use_build_context_synchronously
                                onsuccess!(context);
                              }
                            },
                          ),
                        );
                      }),
                      ////////////
                      // SizedBox(
                      //   width: screenWidth * .4,
                      // ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: variations.map((variation) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: InkWell(
                      //         onTap: () {
                      //           selectedVariationId = variation.id.toString();
                      //           setState;
                      //           if (kDebugMode) {
                      //             print('setted');
                      //             print(selectedVariationId);
                      //             print(variation.id.toString());
                      //           }
                      //           setState(() {});
                      //         },
                      //         child: Container(
                      //           padding: const EdgeInsets.all(5),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(12),
                      //               border: Border.all(
                      //                   color: (selectedVariationId ==
                      //                           variation.id.toString())
                      //                       ? AppColors.primaryColor
                      //                       : Colors.transparent)),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               CustomNetworkImage(
                      //                 imageUrl: variation.image ?? '',
                      //                 height: 40,
                      //                 width: 40,
                      //               ),
                      //               smallHeight,
                      //               SizedBox(
                      //                   width: screenWidth * .15,
                      //                   child: Text(variation.variationName ?? '')),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                    ],
                  ),
                ));
          }));
    },
  );
}

// Future<Map<String, dynamic>?> showVariationDialog(
//     BuildContext context, List<Variation> variations,
//     {required Function(String variationId, String quantity) ontapOk}) {
//   return showDialog<Map<String, dynamic>>(
//     context: context,
//     builder: (context) {
//       String? selectedVariationId;
//       int selectedQuantity = 1;
//       return AlertDialog(
//         actionsPadding: EdgeInsets.zero,
//         insetPadding: EdgeInsets.zero,
//         contentPadding: const EdgeInsets.only(left: 20),
//         title: const Text('Select a Variation'),
//         content: StatefulBuilder(
//           builder: (context, setState) {
//             return ;
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(null),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (selectedVariationId != null && selectedQuantity != null) {
//                 Navigator.of(context).pop();
//                 ontapOk(selectedVariationId!, selectedQuantity.toString());
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content: Text('Please select a variation and quantity')),
//                 );
//               }
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }



// SizedBox(
//               width: screenWidth * .4,
//               height: screenWidth * .45,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: screenWidth * .05),
//                     child: Row(
//                       children: [
//                         const DataBox(
//                           quntity: 'Quantity',
//                           price: '	Price in ₹',
//                           margin: 'Margin in %',
//                           isSelected: false,
//                           borderColor: AppColors.primaryColor,
//                         ),
//                         smallWidth,
//                         Consumer<ProductDetailController>(
//                             builder: (context, controller, child) {
//                           return Expanded(
//                             child: SizedBox(
//                               width: screenWidth * .7,
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.only(left: 6, right: 6),
//                                   child: Builder(builder: (context) {
//                                     return Row(
//                                       children: List.generate(
//                                         controller.productDetailData?.data
//                                                 ?.product?.variations?.length ??
//                                             0,
//                                         (index) => Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               controller.changeAddedVar(
//                                                   VariationAddition(
//                                                       id: controller
//                                                           .productDetailData
//                                                           ?.data
//                                                           ?.product
//                                                           ?.variations?[index]
//                                                           .id,
//                                                       toQty: controller
//                                                           .productDetailData
//                                                           ?.data
//                                                           ?.product
//                                                           ?.variations?[index]
//                                                           .toQty,
//                                                       fromQty: controller
//                                                           .productDetailData
//                                                           ?.data
//                                                           ?.product
//                                                           ?.variations?[index]
//                                                           .fromQty));
//                                               controller.changeQuantity(
//                                                   int.parse(controller
//                                                           .productDetailData
//                                                           ?.data
//                                                           ?.product
//                                                           ?.variations?[index]
//                                                           .toQty ??
//                                                       '1'));
//                                             },
//                                             child: DataBox(
//                                                 borderColor:
//                                                     AppColors.primaryColor,
//                                                 quntity:
//                                                     '${controller.productDetailData?.data?.product?.variations?[index].toQty ?? ''}${controller.productDetailData?.data?.product?.variations?[index].fromQty == '+' ? '' : '-'}${controller.productDetailData?.data?.product?.variations?[index].fromQty ?? ''}',
//                                                 price:
//                                                     '₹${controller.productDetailData?.data?.product?.variations?[index].price ?? ''}',
//                                                 margin:
//                                                     '${controller.productDetailData?.data?.product?.variations?[index].margin ?? ''}%',
//                                                 // ignore: unnecessary_string_interpolations
//                                                 isSelected: (controller
//                                                             .addedVariation
//                                                             .id ??
//                                                         0) ==
//                                                     controller
//                                                         .productDetailData
//                                                         ?.data
//                                                         ?.product
//                                                         ?.variations?[index]
//                                                         .id),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                               ),
//                             ),
//                           );
//                         })
//                       ],
//                     ),
//                   ),
//                   mediumHeight,
//                   Consumer<ProductDetailController>(
//                       builder: (context, controller, child) {
//                     return Padding(
//                       padding: EdgeInsets.only(
//                           left: screenWidth * .05, right: screenWidth * .05),
//                       child: Builder(builder: (context) {
//                         const color = AppColors.grey;
//                         return Container(
//                           height: 50,
//                           width: screenWidth * .8,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: color,
//                                 width: 2,
//                               ),
//                               borderRadius: BorderRadius.circular(30),
//                               color: Colors.white),
//                           // padding: EdgeInsets.only(left: 40, right: 40),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: IconButton(
//                                         padding: EdgeInsets.zero,
//                                         onPressed: () {
//                                           int toQty = int.parse(
//                                               controller.addedVariation.toQty ??
//                                                   '1');
//                                           if (controller.quantity > toQty) {
//                                             controller.decrimentQuantity();
//                                           }
//                                         },
//                                         icon: const Icon(Icons.remove)),
//                                   ),
//                                   Container(height: 50, width: 2, color: color),
//                                 ],
//                               ),
//                               Text(
//                                 '${controller.quantity}',
//                                 style: Theme.of(context).textTheme.titleLarge,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(height: 50, width: 2, color: color),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: IconButton(
//                                         padding: EdgeInsets.zero,
//                                         onPressed: () {
//                                           if (controller
//                                                   .addedVariation.fromQty ==
//                                               '+') {
//                                             controller.incrimentQuantity();
//                                           } else {
//                                             int fromQty = int.parse(controller
//                                                     .addedVariation.fromQty ??
//                                                 '1');

//                                             if (controller.quantity < fromQty) {
//                                               controller.incrimentQuantity();
//                                             }
//                                           }
//                                         },
//                                         icon: const Icon(Icons.add)),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                     );
//                   }),
//                   ////////////
//                   // SizedBox(
//                   //   width: screenWidth * .4,
//                   // ),
//                   // Row(
//                   //   mainAxisSize: MainAxisSize.min,
//                   //   mainAxisAlignment: MainAxisAlignment.start,
//                   //   children: variations.map((variation) {
//                   //     return Padding(
//                   //       padding: const EdgeInsets.all(8.0),
//                   //       child: InkWell(
//                   //         onTap: () {
//                   //           selectedVariationId = variation.id.toString();
//                   //           setState;
//                   //           if (kDebugMode) {
//                   //             print('setted');
//                   //             print(selectedVariationId);
//                   //             print(variation.id.toString());
//                   //           }
//                   //           setState(() {});
//                   //         },
//                   //         child: Container(
//                   //           padding: const EdgeInsets.all(5),
//                   //           decoration: BoxDecoration(
//                   //               borderRadius: BorderRadius.circular(12),
//                   //               border: Border.all(
//                   //                   color: (selectedVariationId ==
//                   //                           variation.id.toString())
//                   //                       ? AppColors.primaryColor
//                   //                       : Colors.transparent)),
//                   //           child: Column(
//                   //             crossAxisAlignment: CrossAxisAlignment.center,
//                   //             children: [
//                   //               CustomNetworkImage(
//                   //                 imageUrl: variation.image ?? '',
//                   //                 height: 40,
//                   //                 width: 40,
//                   //               ),
//                   //               smallHeight,
//                   //               SizedBox(
//                   //                   width: screenWidth * .15,
//                   //                   child: Text(variation.variationName ?? '')),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     );
//                   //   }).toList(),
//                   // ),
//                   smallHeight,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomIconImage(
//                           onPress: () {
//                             if (selectedQuantity > 1) selectedQuantity--;
//                             setState(
//                               () {},
//                             );
//                           },
//                           icon: const Icon(Icons.remove)),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15, right: 15),
//                         child: Text(
//                           "$selectedQuantity",
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                       ),
//                       CustomIconImage(
//                           onPress: () {
//                             selectedQuantity++;
//                             setState(
//                               () {},
//                             );
//                           },
//                           icon: const Icon(Icons.add)),
//                     ],
//                   )
//                 ],
//               ),
//             )