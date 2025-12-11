import 'package:cubit_pro/core/utiles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


void showToastificationWidget({
  required String message,
  required BuildContext context,
  ToastificationType notificationType = ToastificationType.success,
  int duration = 2,
}) {
  const backgroundColor = Color(0xFF231F1E);
  final textColor = Colors.white;

  Color borderColor;

  switch (notificationType) {
    case ToastificationType.success:
      borderColor = Colors.green.shade600;
      break;
    case ToastificationType.error:
      borderColor = Colors.red.shade600;
      break;
    case ToastificationType.warning:
      borderColor = Colors.orange.shade600;
      break;
    case ToastificationType.info:
      borderColor = Colors.blue.shade600;
      break;
    default:
      borderColor = Colors.grey;
  }
  toastification.dismissAll();
  toastification.show(
    context: context,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            textAlign: TextAlign.start,
            maxLines: 3,
            style: AppStyles.medium16(context).copyWith(color: textColor),
          ),
        ),
      ],
    ),
    type: notificationType,
    foregroundColor: borderColor,
    style: ToastificationStyle.flat,
    alignment: Alignment.topCenter,
    direction: TextDirection.rtl,
    showProgressBar: true,
    progressBarTheme: ProgressIndicatorThemeData(color: borderColor),
    autoCloseDuration: Duration(seconds: duration),
    backgroundColor: backgroundColor,
    borderSide: BorderSide(width: 1, color: borderColor.withValues(alpha: 0.8)),
  );
}
