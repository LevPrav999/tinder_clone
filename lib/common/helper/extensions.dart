import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'show_alert_dialog.dart';

extension AsyncValueUI on AsyncValue {
  void showDialogOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      showAlertDialog(context: context, message: value!);
    }
  }
}