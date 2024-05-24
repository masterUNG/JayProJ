import 'package:flutter/material.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';
import 'package:jayproj/widgets/widget_text.dart';

class WidgetButtonScan extends StatelessWidget {
  const WidgetButtonScan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      padding: const EdgeInsets.all(8),
      decoration: AppConstant().radiusBorder(),
      child: const AspectRatio(
        aspectRatio: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetImageAsset(
              path: 'images/qr.png',
              size: 48,
            ),
            SizedBox(
              height: 8,
            ),
            WidgetText(data: 'Scan')
          ],
        ),
      ),
    );
  }
}
