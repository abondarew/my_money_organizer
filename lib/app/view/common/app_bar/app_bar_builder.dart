import 'package:flutter/cupertino.dart';
import 'package:mymoneyorganizer/app/view/common/app_bar/scroll_handled_appbar.dart';

class AppBarBuilder {
  static PreferredSizeWidget buildAppBar({
    required BuildContext context,
    Key? key,
    Widget? leading,
    ScrollController? scrollController,
    PreferredSizeWidget? bottom,
    Widget? title,
    List<Widget>? action,
  }) {
    return ScrollHandledAppBar(
      key: key,
      leading: leading,
      scrollController: scrollController,
      bottom: bottom,
      title: title,
      action: action,
    );
  }
}
