import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

import '../../app/core/core.dart';

class SnackBarInfo extends SnackBar {
  SnackBarInfo({Key? key, required String text, required bool isError})
      : super(
          key: key,
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTheme.textStyles.labelMediumBold
                .copyWith(color: Colors.white),
          ),
          backgroundColor: isError ? Colors.red : Colors.green,
        );
}
