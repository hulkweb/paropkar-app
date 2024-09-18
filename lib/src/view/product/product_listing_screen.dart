import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
import 'package:paropkar/src/utills/globle_func.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/app_bottom_navigation_bar.dart';
import 'package:paropkar/src/view/cart/cart_screen.dart';
import 'package:paropkar/src/view/product/product_detail_screen.dart';
import 'package:paropkar/src/custom_widgets/cards/product_card_custom.dart';
import 'package:provider/provider.dart';
class ProductListingScreen extends StatelessWidget{
  ProductListingScreen({super.key});
  final productListingController = ProductListingController();
  @override
  Widget build(BuildContext context) {
     final bottomController =
        Provider.of<BottomBarListController>(context);
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
                  bottomController.changeIndex(2);
                  productListingController.ontapProductCart(context: context);
                  // Handle add to cart press
                },
                onProductPressed: (){
                  AppNavigation.navigationPush(
                      context,  ProductDetailScreen());  
                },
              ),
            )),
      ),
    );
  }
}