import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/bloc_provider/category/category_block.dart';
import 'package:paropkar/src/bloc_provider/category/category_event.dart';
import 'package:paropkar/src/bloc_provider/category/category_state.dart';
import 'package:paropkar/src/bloc_provider/product/product_block.dart';
import 'package:paropkar/src/bloc_provider/product/product_event.dart';
import 'package:paropkar/src/bloc_provider/product/product_state.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/cart/cart_controller.dart';
import 'package:paropkar/src/controller/product/product_detail_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/constants.dart';
import 'package:paropkar/src/utills/dimentions.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/view/product/product_listing_screen.dart';
import 'package:paropkar/src/custom_widgets/carousel_widget.dart';
import 'package:paropkar/src/custom_widgets/custom_buttons/view_all_button.dart';
import 'package:paropkar/src/custom_widgets/custom_status_bar.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
import 'package:paropkar/src/view/product/product_listing_screen_new.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final bottomBarListController = BottomBarListController();
  @override
  Widget build(BuildContext context) {
    final bottomController = Provider.of<BottomBarListController>(context);
    // final categoryListingController =
    //     Provider.of<CategoryListingController>(context);
    final cartController = Provider.of<CartController>(context, listen: true);
    context.read<CategoryBloc>().add(FetchCategories());
    context.read<ProductBloc>().add(FetchProducts());
    return StatusBarCustom(
      statusBarBrightnessLight: true,
      statusBarColor: AppColors.primaryColor,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.primaryColor,
                child: Column(
                  children: [
                    mediumHeight,
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Padding(
                          //     padding: const EdgeInsets.only(left: 5),
                          //     child: Icon(
                          //       Icons.arrow_back_ios,
                          //       color: Theme.of(context).cardColor,
                          //     ),
                          //   ),
                          // ),
                          smallWidth,
                          ////
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ],
                                ),
                                Text('Bhopal, Awadhpuri',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(color: AppColors.white)),
                              ],
                            ),
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
                    SizedBox(
                      height: 70,
                      width: screenWidth,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Search Your Grocery',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primaryColor),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: AppColors.primaryColor,
                            ),
                            contentPadding: const EdgeInsets.only(left: 30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            // focusedErrorBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(30),
                            //   borderSide: BorderSide.none,
                            // ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Promo Banner
                    // SizedBox(
                    //   height: screenHeight*.4,width: screenWidth*.9,
                    //   child: Expanded(child: ImageCarousel(imageUrls: [],))),
                    // Container(
                    //   padding: EdgeInsets.all(16),
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     color: Colors.green,
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Get 40% Discount',
                    //         style: TextStyle(color: Colors.white, fontSize: 20),
                    //       ),
                    //       Text(
                    //         'On Your First Order From App',
                    //         style: TextStyle(color: Colors.white, fontSize: 16),
                    //       ),
                    //       Spacer(),
                    //       ElevatedButton(
                    //         onPressed: () {},
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.white,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(20),
                    //           ),
                    //         ),
                    //         child: Text(
                    //           'Shop Now',
                    //           style: TextStyle(color: Colors.green),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    ImageCarousel(
                      imageUrls: List.generate(4, (index) => AppAssets.banner),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // Categories Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ViewAllButton(
                          onPressed: () {
                            bottomController.changeIndex(1);
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Categories List
                    BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                      print('state name $state');
                      DataStatus dataStatus = (state is CategoryLoading)
                          ? DataStatus.loading
                          : (state is CategorySuccess)
                              ? DataStatus.success
                              : DataStatus.error;
                      print('=============');
                      print(dataStatus);
                      return DataStateWidget(
                        status: dataStatus,
                        ontapRetry: () {
                          context.read<CategoryBloc>().add(FetchCategories());
                        },
                        loadingWidget: const SizedBox(),
                        isDataEmpty: state is CategorySuccess
                            ? ((state.categoryData.categories == null) ||
                                (state.categoryData.categories!.isEmpty))
                            : false,
                        child: SizedBox(
                          height: screenWidth * .4,
                          child: ListView(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: state is CategorySuccess
                                  ? ((state.categoryData.categories == null) ||
                                          (state.categoryData.categories!
                                              .isEmpty))
                                      ? [const SizedBox()]
                                      : List.generate(
                                          state.categoryData.categories!.length,
                                          (index) {
                                          final category = state
                                              .categoryData.categories![index];
                                          return Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: CategoryItem(
                                                ontap: () {
                                                  AppNavigation.navigationPush(
                                                      context,
                                                      const ProductListingScreenNew());
                                                },
                                                name: category.name ?? '',
                                                imagePath:
                                                    category.image ?? ''),
                                          );
                                        })
                                  : []),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),

                    // Popular Section
                    Text(
                      'Popular',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    // Popular Items Grid
                    BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                      DataStatus dataStatus = state is ProductListingLoading
                          ? DataStatus.loading
                          : state is ProductListingSuccess
                              ? DataStatus.success
                              : DataStatus.error;
                      return DataStateWidget(
                        status: dataStatus,
                        ontapRetry: () {
                          context.read<ProductBloc>().add(FetchProducts());
                        },
                        loadingWidget: const SizedBox(),
                        isOverlay: false,
                        // isDataEmpty:  (controller.productListData!.data != null) &&
                        //         (controller.productListData!.data!.isEmpty),
                        isDataEmpty: (state is ProductListingSuccess) &&
                            ((state.productListData.data == null) ||
                                state.productListData.data!.isEmpty),
                        child: state is ProductListingSuccess
                            ? GridView.count(
                                crossAxisCount: 2,
                                padding: EdgeInsets.all(screenWidth * .04),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.6,
                                children: (state.productListData.data ==
                                            null) ||
                                        (state.productListData.data!.isEmpty)
                                    ? []
                                    : List.generate(
                                        state.productListData.data!.length,
                                        (index) {
                                          final product = state
                                              .productListData.data![index];
                                          return ProductCard(
                                            imageUrl: product.image ??
                                                '', // AppAssets.maida, // Replace with actual image URL
                                            productName: product.name ?? '',
                                            price: "₹${product.price ?? ''}",
                                            categoryName: product.category ==
                                                    null
                                                ? ""
                                                : product.category!.name ??
                                                    '', //"Buy 3 Items, Save Extra 5%",
                                            isFavorite: index % 2 == 0,
                                            onFavoritePressed: () {
                                              // Handle favorite icon press
                                            },
                                            onAddToCartPressed: () async {
                                              cartController.addCart(
                                                  product_id:
                                                      product.id.toString(),
                                                  variation_id: '1',
                                                  quantity: "1",
                                                  context: context);
                                            },
                                            onProductPressed: () {
                                              context
                                                  .read<
                                                      ProductDetailController>()
                                                  .getProductDetail(context,
                                                      id: '${product.id ?? ''}',
                                                      category_id:
                                                          '${product.categoryId ?? ''}',
                                                      subcategory_id:
                                                          '${product.subcategoryId ?? ''}');
                                              // same functions result

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
                                          );
                                        },
                                      ))
                            : const SizedBox(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Category Item Widget
class CategoryItem extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback ontap;

  const CategoryItem(
      {super.key,
      required this.name,
      required this.imagePath,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          onTap: ontap,
          child: Container(
            width: screenWidth * .3,
            height: screenWidth * .3,
            decoration: BoxDecoration(
              color: const Color(0xffFFFBF0),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.2), offset: Offset(1, 1))
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage(AppUrl.imageUrl + imagePath),
                fit: BoxFit.cover,
              ),
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
