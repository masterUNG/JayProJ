// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';

class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      urlImage,
      errorBuilder: (context, error, stackTrace) =>
          const WidgetImageAsset(path: 'images/image.png'),
    );
  }
}
