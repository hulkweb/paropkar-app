import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_bloc.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_event.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class FavoriteListingScreen extends StatelessWidget {
  const FavoriteListingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // final bottomController = Provider.of<BottomBarListController>(context);

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
                      Text('Favorite List',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColors.white)),

                      IconButton(
                        onPressed: () {},
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
        body:
            Consumer<FavoriteController>(builder: (context, controller, child) {
          // print(controller.productDataStatus);
          return DataStateWidget(
              status: controller.favoritesDataStatus,
              ontapRetry: () {
                controller.changeFavoritesDataStatus(DataStatus.loading);
                controller.getFavorites();
              },
              isOverlay: controller.addFavoriteDataStatus == DataStatus.loading,
              // isDataEmpty:  (controller.favorites!.data != null) &&
              //         (controller.favorites!.data!.isEmpty),
              isDataEmpty: (controller.favorites == null) ||
                  (controller.favorites!.data == null) ||
                  (controller.favorites!.data!.isEmpty),
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(screenWidth * .04),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 7,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
                children: (controller.favorites == null) ||
                        (controller.favorites!.data == null) ||
                        (controller.favorites!.data!.isEmpty)
                    ? []
                    : List.generate(controller.favorites!.data!.length,
                        (index) {
                        final favorite = controller.favorites!.data![index];
                        return ProductCard(
                          imageUrl: favorite.product!.image ??
                              '', // AppAssets.maida, // Replace with actual image URL
                          productName: favorite.product!.name ?? '',
                          price: "₹${favorite.product!.price ?? ''}",
                          categoryName: '',
                          // favorite.product!.c == null
                          //     ? ""
                          //     : favorite.product!.category!.name ??
                          //         '', //"Buy 3 Items, Save Extra 5%",
                          isFavorite: true,
                          onFavoritePressed: () {
                            // Handle favorite icon press
                          },
                          onAddToCartPressed: () async {
                            context.read<CartBloc>().add(AddCartItem(
                                productId: favorite.product!.id.toString(),
                                quantity: "1"));
                          },
                          onProductPressed: () {
                            context
                                .read<ProductDetailController>()
                                .getProductDetail(context,
                                    id: '${favorite.product!.id ?? ''}',
                                    category_id:
                                        '${favorite.product!.categoryId ?? ''}',
                                    subcategory_id:
                                        '${favorite.product!.subcategoryId ?? ''}');
                            // same functions result

                            AppNavigation.navigationPush(
                                context,
                                ProductDetailScreenNew(
                                  id: '${favorite.product!.id ?? ''}',
                                  categoryId:
                                      '${favorite.product!.categoryId ?? ''}',
                                  subcategoryId:
                                      '${favorite.product!.subcategoryId ?? ''}',
                                ));
                          },
                        );
                      }),
              ));
        }),
      ),
    );
  }
}
