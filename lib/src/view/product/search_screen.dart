import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key, this.categoryName, this.categoryId});
  final String? categoryName;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context, listen: true);
    final favoriteController =
        Provider.of<FavoriteController>(context, listen: true);
    final bottomBarController = Provider.of<BottomBarListController>(context);
    final TextEditingController searchTextController = TextEditingController();
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
                        onPressed:(){
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
                      SizedBox(
                        width: 150,
                        child: Text("Products",
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
        body: Column(
          children: [
            // Adding the search field
            Padding(
              padding: const EdgeInsets.only(bottom: 0,left: 16,right: 16,top: 16),
              child: TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (value) async {
                  // TODO: Add search logic here
                  await context.read<ProductListingController>().getProducts(
                      search: searchTextController.text, loading: false);
                },
                onChanged: (query) async {},
              ),
            ),
            Expanded(
              child: Consumer<ProductListingController>(
                builder: (context, controller, state) {
                  return DataStateWidget(
                    status: controller.productDataStatus,
                    ontapRetry: () {
                      controller.getProducts();
                    },
                    isOverlay: cartController.addCartDataStatus ==
                            DataStatus.loading ||
                        favoriteController.addFavoriteDataStatus ==
                            DataStatus.loading,
                    isDataEmpty:
                        controller.productDataStatus == DataStatus.success &&
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
                                      final product = controller
                                          .productsData!.data!.data![index];
                                      return ProductCard(
                                        imageUrl: product.image ?? '',
                                        productName: product.name ?? '',
                                        price: "₹${product.price ?? ''}",
                                        categoryName: product.category == null
                                            ? ""
                                            : product.category!.name ?? '',
                                        isFavorite: product.isFavorite ?? false,
                                        onFavoritePressed: () async {
                                          await favoriteController
                                              .addRemoveFavorite(
                                                  product_id:
                                                      product.id.toString(),
                                                  context: context);
                                          await controller.getProducts(
                                              search: searchTextController.text,
                                              loading: false);
                                        },
                                        onAddToCartPressed: () async {
                                          if (!(product.isCart ?? false)) {
                                            await cartController.addCart(
                                                variation_id: product
                                                    .variations![0].id
                                                    .toString(),
                                                product_id:
                                                    product.id.toString(),
                                                quantity: "1",
                                                context: context);
                                            await controller.getProducts(
                                                search:
                                                    searchTextController.text,
                                                loading: false);
                                          } else {
                                            AppNavigation.pushAndRemoveUntil(
                                                context,
                                                const BottomBarListScreen());
                                            bottomBarController.changeIndex(2);
                                          }
                                        },
                                        onProductPressed: () {
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
