import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_bloc.dart';
import 'package:paropkar/src/bloc_provider/cart/cart_event.dart';
import 'package:paropkar/src/bloc_provider/product/product_block.dart';
import 'package:paropkar/src/bloc_provider/product/product_event.dart';
import 'package:paropkar/src/bloc_provider/product/product_state.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/favorite/favorite_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListingScreenNew extends StatelessWidget {
  const ProductListingScreenNew({super.key});
  @override
  Widget build(BuildContext context) {
    // final bottomController = Provider.of<BottomBarListController>(context);
    final cartController = Provider.of<CartController>(context, listen: true);

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
                      InkWell(
                        onTap: () {
                          ProductListingController().getProducts();
                        },
                        child: Text('Pulses',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.white)),
                      ),

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
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          DataStatus dataStatus = (state == ProductListingLoading)
              ? DataStatus.loading
              : (state == ProductListingSuccess)
                  ? DataStatus.success
                  : DataStatus.error;
          final productData;
          if (state is ProductListingSuccess) {
            productData = state.productListData;
          }

          // print(controller.productDataStatus);
          return DataStateWidget(
              status: dataStatus,
              ontapRetry: () {
                context.read<ProductBloc>().add(FetchProducts());
              },
              isOverlay: cartController.addCartDataStatus == DataStatus.loading,
              // isDataEmpty:  (controller.productsData!.data != null) &&
              //         (controller.productsData!.data!.isEmpty),
              isDataEmpty: false,
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(screenWidth * .04),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 7,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
                children: false
                    ? []
                    : List.generate(5, (index) {
                        var product;
                        return ProductCard(
                          imageUrl: product.image ??
                              '', // AppAssets.maida, // Replace with actual image URL
                          productName: product.name ?? '',
                          price: "₹${product.price ?? ''}",
                          categoryName: product.category == null
                              ? ""
                              : product.category!.name ??
                                  '', //"Buy 3 Items, Save Extra 5%",
                          isFavorite: false,
                          onFavoritePressed: () async {
                            // Handle favorite icon press
                            await Provider.of<FavoriteController>(context,
                                    listen: false)
                                .addFavorite(
                                    product_id: product.id.toString(),
                                    context: context);
                          },
                          onAddToCartPressed: () async {
                            context.read<CartBloc>().add(AddCartItem(
                                productId: product.id,
                                quantity: product.quantity));
                          },
                          onProductPressed: () {
                            context
                                .read<ProductDetailController>()
                                .getProductDetail(context,
                                    id: '${product.id ?? ''}',
                                    category_id: '${product.categoryId ?? ''}',
                                    subcategory_id:
                                        '${product.subcategoryId ?? ''}');
                            // same functions result

                            AppNavigation.navigationPush(
                                context,
                                ProductDetailScreenNew(
                                  id: '${product.id ?? ''}',
                                  categoryId: '${product.categoryId ?? ''}',
                                  subcategoryId:
                                      '${product.subcategoryId ?? ''}',
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
