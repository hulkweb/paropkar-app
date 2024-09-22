import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paropkar/src/bloc_provider/category/category_block.dart';
import 'package:paropkar/src/bloc_provider/category/category_event.dart';
import 'package:paropkar/src/bloc_provider/category/category_state.dart';
import 'package:paropkar/src/controller/bottom_bar_controller.dart';
import 'package:paropkar/src/custom_widgets/cards/category_card_custom.dart';
import 'package:paropkar/src/custom_widgets/data_status_widget.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/navigation_function.dart';
import 'package:paropkar/src/view/product/product_listing_screen.dart';
import 'package:paropkar/src/view/product/product_listing_screen_new.dart';
import 'package:provider/provider.dart';

class CategoryListingScreenNew extends StatelessWidget {
  const CategoryListingScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomController = Provider.of<BottomBarListController>(context);
      // Dispatch the FetchCategories event when the widget builds
    context.read<CategoryBloc>().add(FetchCategories());
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
                  color: AppColors.primaryColor,
                ),
                titlePadding: const EdgeInsets.only(top: 30),
                expandedTitleScale: 1,
                title: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                      Text('Category',
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
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            // ignore: unrelated_type_equality_checks
            DataStatus  dataStatus = (state is CategoryLoading)?DataStatus.loading:(state is CategorySuccess)?DataStatus.success:DataStatus.error;
            if (state is CategoryLoading) {
              print('state name');
              print(state);
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryFailure) {
              return DataStateWidget(
                status: dataStatus, // Assuming you have a way to represent this
                ontapRetry: () {
                  context.read<CategoryBloc>().add(FetchCategories());
                },
                isDataEmpty: true, child: null,
              );
            } else if (state is CategorySuccess) {
              final  categoryData = state.categoryData; // Access your  categoryData list
              
              return DataStateWidget(
                status: DataStatus.success,
                ontapRetry: () {
                  context.read<CategoryBloc>().add(FetchCategories());
                },
                isDataEmpty:  categoryData.categories!.isEmpty,
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.width * .95,
                  children: List.generate(
                     categoryData.categories!.length,
                    (index) {
                      final category =  categoryData.categories![index];
                      return CategoryCard(
                        imageUrl: category.image ?? '', // Replace with actual image URL
                        categoryText: category.name ?? '',
                        onPressed: () {
                          AppNavigation.navigationPush(context, ProductListingScreenNew());
                        },
                      );
                    },
                  ),
                ),
              );
            } else {
              return Container(); // You can return a default state if needed
            }
          },
        ),
      ),
    );
  }
}
