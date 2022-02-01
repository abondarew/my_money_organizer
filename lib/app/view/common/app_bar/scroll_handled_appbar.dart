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
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(scrollListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(scrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: displayElevation ? null : 0,
      leading: widget.leading,
      title: widget.title,
      actions: widget.action,
      bottom: widget.bottom,
    );
  }

  void scrollListener() {
    bool displayE = false;
    if (widget.scrollController!.offset > 1) {
      displayE = true;
    }
    if (displayE != displayElevation) {
      setState(() {
        displayElevation = displayE;
      });
    }
  }
}
