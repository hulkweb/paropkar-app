import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/widgets/product_card.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      ////
                      Text('Pulses',
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
        body: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(screenWidth * .04),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
            children: List.generate(
              10,
              (index) => ProductCard(
                imageUrl: AppAssets.maida, // Replace with actual image URL
                productName: "Toor Daal",
                price: "₹150.00",
                offerText: "Buy 3 Items, Save Extra 5%",
                isFavorite: index % 2 == 0,
                onFavoritePressed: () {
                  // Handle favorite icon press
                },
                onAddToCartPressed: () async {
                  // Handle add to cart press
                  AppNavigation.navigation(context, CartScreen());
                },
                onProductPressed: () {
                  AppNavigation.navigation(context, ProductDetailScreen());
                },
              ),
            )),
      ),
    );
  }
}

