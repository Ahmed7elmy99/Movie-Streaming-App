
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../global/resources/app_color.dart';
import '../../global/resources/values_manager.dart';
import '../../network/api_constance.dart';

class PosterImage extends StatelessWidget {
  const PosterImage({
    super.key,
    required this.posterPath,
  });

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: BlackBorder(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: CachedNetworkImage(
            height: AppSize.s170,
            width: AppSize.s120,
            fit: BoxFit.cover,
            imageUrl: ApiConstance.imageUrl(posterPath),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[AppColorShades.colorShade850]!,
              highlightColor: Colors.grey[AppColorShades.colorShade800]!,
              child: Container(
                height: AppSize.s170,
                width: AppSize.s120,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
class BlackBorder extends StatelessWidget {
  const BlackBorder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: AppSize.s0_5,
        ),
        borderRadius: BorderRadius.circular(AppRadius.r8),
      ),
      child: child,
    );
  }
}
