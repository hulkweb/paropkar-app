import 'package:flutter/material.dart';
import 'package:paropkar/main.dart';
import 'package:paropkar/src/utills/app_colors.dart';

// Custom Category Card Widget
class CategoryCard extends StatelessWidget {
  final String categoryText;
  final String imageUrl;
  final VoidCallback onPressed;

  const CategoryCard({
    Key? key,
    required this.categoryText,
    required this.imageUrl,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 1,
        child: Container(
          margin: const EdgeInsets.all(.0),
          padding: const EdgeInsets.only(
            top: 0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Shadow color
                spreadRadius: 2, // How far the shadow spreads
                blurRadius: 8, // Softness of the shadow
                offset: const Offset(0, 3), // Position of shadow (x, y)
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imageUrl,
                    height: screenWidth * .3,
                    width: screenWidth * .3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  categoryText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
