import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  final String pathURL;
  final double width, height, radius;
  const MyNetworkImage(
      {super.key,
      required this.pathURL,
      required this.width,
      required this.height,
      required this.radius});

  @override
  Widget build(BuildContext context) {
    return buildImage(pathURL, width, height, radius);
  }

  Widget buildImage(
      String pathURL, double width, double height, double radius) {
    return SizedBox(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: pathURL == ''
              ? Image.asset('assets/riserescuelogo.png', fit: BoxFit.cover)
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: pathURL,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
        ));
  }
}
