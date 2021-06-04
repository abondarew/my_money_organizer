import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollHandledAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  @override
  final Size preferredSize;
  final ScrollController? scrollController;

  ScrollHandledAppBar({Key? key, this.leading, this.title, this.action, this.bottom, this.scrollController})
      : preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScrollHandledAppBar> {
  bool displayElevation = false;

  @override
  void initState() {
    if (this.widget.scrollController != null) {
      this.widget.scrollController!.addListener(this.scrollListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (this.widget.scrollController != null) {
      this.widget.scrollController!.removeListener(this.scrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: displayElevation ? null : 0,
      leading: this.widget.leading,
      title: this.widget.title,
      actions: this.widget.action,
      bottom: this.widget.bottom,
    );
  }

  void scrollListener() {
    bool displayE = false;
    if (this.widget.scrollController!.offset > 1) {
      displayE = true;
    }
    if (displayE != displayElevation) {
      setState(() {
        displayElevation = displayE;
      });
    }
  }
}
