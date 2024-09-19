import 'package:flutter/material.dart';
import 'package:paropkar/src/utills/constants.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = 200.0,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
     AppUrl.imageUrl + imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;  // Image loaded successfully
        }
        return placeholder ??
            Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes!)
                    : null,
              ),
            );
      },
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return  errorWidget ??SizedBox(width:width ,height: height,
          child:
              Center(
                child: Icon(Icons.error, size: 50, color: Colors.red.withOpacity(.1)),
              ),
        );
      },
    );
  }
}
