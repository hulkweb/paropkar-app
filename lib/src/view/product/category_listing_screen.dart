import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/bloc_provider/category/category_block.dart';
import 'package:paropkar/src/bloc_provider/category/category_state.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/controller/category/category_controller.dart';
import 'package:paropkar/src/controller/category/sub_category_controller%20copy.dart';
import 'package:paropkar/src/controller/product/product_listing_controller.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_assets.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/notification/notification_list_screen.dart';
import 'package:paropkar/src/view/product/product_listing_screen.dart';
import 'package:paropkar/src/custom_widgets/cards/category_card_custom.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListingScreen extends StatelessWidget{
  const CategoryListingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bottomController = Provider.of<BottomBarListController>(context);
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
                          bottomController.changeIndex(0);
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
                      Text('Categories',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColors.white)),

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
        body: Consumer<CategoryListingController>(
            builder: (context, controller, state) {
          return DataStateWidget(
            status: controller.categoryDataStatus,
            ontapRetry:(){
              controller.getCategories();
            },
            isDataEmpty: controller.categoryData == null ||
                (controller.categoryData!.data == null) ||
                (controller.categoryData!.data!.isEmpty),
            child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(screenWidth * .04),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: screenWidth / screenWidth * .95,
                children: (controller.categoryData == null) ||
                        (controller.categoryData!.data == null) ||
                        (controller.categoryData!.data!.isEmpty)
                    ? [const SizedBox()]
                    : List.generate(controller.categoryData!.data!.length,
                        (index) {
                        final category = controller.categoryData!.data![index];
                        return CategoryCard(
                          imageUrl: category.image ??
                              '', // Replace with actual image URL
                          categoryText: category.name ?? '',
                          onPressed: () {
                            context.read<ProductListingController>().getProducts(category_id: category.id.toString());
                            AppNavigation.navigationPush(context,  ProductListingScreen(categoryName: category.name,));},
                        );
                      })),
          );
        }),
      ),
    );
  }
}
