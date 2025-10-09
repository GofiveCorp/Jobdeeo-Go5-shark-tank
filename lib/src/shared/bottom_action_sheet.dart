import 'package:flutter/cupertino.dart';
import 'package:jobdeeo/src/core/base/txt_styles.dart';
import 'package:jobdeeo/src/core/color_resources.dart';



class BaseActionSheet {
  static void show({
    required BuildContext context,
    String? title,
    required List<BaseActionSheetAction> actions,
    BaseActionSheetAction? cancelButton,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: title != null ? Text(title) : null,
          actions: actions.map((action) {
            return CupertinoActionSheetAction(
              child: Text(action.text, style: fontTitle.copyWith(color: ColorResources.primaryColor)),
              onPressed: () {
                Navigator.pop(context);
                action.onPressed?.call();
              },
            );
          }).toList(),
          cancelButton: cancelButton != null
              ? CupertinoActionSheetAction(
                  isDefaultAction: cancelButton.isDefaultAction,
                  onPressed: () {
                    Navigator.pop(context);
                    cancelButton.onPressed?.call();
                  },
                  child: Text(cancelButton.text, style: fontTitle.copyWith(color: ColorResources.primaryColor)),
                )
              : null,
        );
      },
    );
  }
}

class BaseActionSheetAction {
  final String text;
  final VoidCallback? onPressed;
  final bool isDefaultAction;

  BaseActionSheetAction({
    required this.text,
    this.onPressed,
    this.isDefaultAction = false,
  });
}
