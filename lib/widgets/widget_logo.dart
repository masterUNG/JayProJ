import 'package:flutter/material.dart';
import 'package:jayproj/utility/app_constant.dart';
import 'package:jayproj/widgets/widget_image_asset.dart';
import 'package:jayproj/widgets/widget_text.dart';

class WidgetLogo extends StatelessWidget {
  const WidgetLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const WidgetImageAsset(
          path: 'images/qr.png',
          size: 36,
        ),
        const SizedBox(
          width: 8,
        ),
        WidgetText(
          data: 'Jay ProJ',
          textStyle: AppConstant().h2Style(),
        ),
      ],
    );
  }
}
