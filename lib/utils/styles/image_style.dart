import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare2050/utils/colors.dart';

Widget showNetworkImageWithCached({
  required String imageUrl,
  required double height,
  required double width,
  required double radius,
  BoxFit fit = BoxFit.cover,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: fit,
      errorWidget: (c, a, b) {
        return imageErrorView(height, width, radius);
      },
      placeholder: (c, s) {
        return imagePlaceHolderView(height, width, radius);
      },
    ),
  );
}

Widget imageErrorView(double height, double width, double radius) {
  return Container(
    height: height,
    width: width,
    child: Center(
      child: Icon(
        Icons.broken_image_outlined,
        color: Colors.grey,
        size: height / 3,
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.4),
        borderRadius: BorderRadius.circular(radius)),
  );
}

Widget imagePlaceHolderView(double height, double width, double radius) {
  return Container(
    height: height,
    width: width,
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: mainColor,
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(radius)),
  );
}

Widget showSVGImage(
    {required String imagePath,
    required double height,
    required double width,
    required double radius,
      Color imageColor = Colors.black,
    BoxFit fit = BoxFit.cover}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: SvgPicture.network(
      imagePath,
      key: Key(imagePath),
      height: height,
      width: width,
      color: imageColor,
      fit: fit,
      placeholderBuilder: (c) => imagePlaceHolderView(height, width, radius),
    ),
  );
}
