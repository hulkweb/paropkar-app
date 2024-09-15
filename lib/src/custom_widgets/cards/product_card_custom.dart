import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';
import 'package:paropkar/src/utills/app_fonts.dart';
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final String offerText;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onAddToCartPressed;
  final VoidCallback onProductPressed;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.offerText,
    this.isFavorite = false,
    required this.onFavoritePressed,
    required this.onAddToCartPressed,
    required this.onProductPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onProductPressed,
      child: Container(
        margin: const EdgeInsets.all(.0),
        padding: const EdgeInsets.only(
          top: 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      imageUrl,
                      width: double.infinity,
                      height: screenHeight * .1,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Product Information
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                productName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Expanded(child: const SizedBox(height: 4.0)),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                offerText,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.medium,
                      overflow: TextOverflow.ellipsis,
                    ),
                maxLines: 2,
              ),
            ),
            const Expanded(child: SizedBox(height: 4.0)),

            // Price and Add to Cart Button
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.primaryColor,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppFonts.semiBold),
                  ),
                  InkWell(
                    onTap: onAddToCartPressed,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(10),
                          )),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: onAddToCartPressed,
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     shape: const CircleBorder(),
                  //     // primary: Colors.green, // Button color
                  //   ),
                  //   child: const Icon(
                  //     Icons.add,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}