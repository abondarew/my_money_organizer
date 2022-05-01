import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/crossfade_animation.dart';

class ExCircleAvatar<T> extends StatefulWidget {
  final ExAvatarSetting avatarSetting;
  final Widget Function(T val) avatarChild;
  final VoidCallback? onTap;
  final T initialData;
  final T data;
  final bool visibleAdditionalControl;

  const ExCircleAvatar({
    Key? key,
    required this.avatarSetting,
    required this.avatarChild,
    this.onTap,
    required this.initialData,
    required this.data,
    this.visibleAdditionalControl = false,
  }) : super(key: key);

  @override
  State<ExCircleAvatar> createState() => _State<T>();
}

class _State<T> extends State<ExCircleAvatar<T>> {
  late bool _visibleAddon = widget.visibleAdditionalControl;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.avatarSetting.avatarSize,
      child: Material(
        type: MaterialType.circle,
        color: widget.avatarSetting.canvasColor,
        elevation: widget.avatarSetting.elevation,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget? _buildContent() {
    if (widget.visibleAdditionalControl) _visibleAddon = true;
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      /*decoration: BoxDecoration(
        color: widget.avatarSetting.backgroundColor,
        borderRadius: BorderRadius.circular(widget.avatarSetting.avatarSize.width),
      ),*/
      decoration: ShapeDecoration(
        shape: CircleBorder(), //StadiumBorder(),
        color: widget.avatarSetting.backgroundColor,
      ),
      child: Stack(
        children: [
          Material(
            shape: StadiumBorder(),
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              //borderRadius: BorderRadius.circular(widget.avatarSetting.avatarSize.width),
              customBorder: StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SizedBox.fromSize(
                    size: widget.avatarSetting.avatarSize,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CrossFade<T>(
                        builder: (val) => widget.avatarChild(val!),
                        data: widget.data,
                        initialData: widget.data,
                        duration: kThemeAnimationDuration,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedOpacity(
              opacity: widget.visibleAdditionalControl ? 1 : 0,
              duration: kThemeAnimationDuration,
              onEnd: _changeVisible,
              child: SizedBox(
                height: 22,
                width: 22,
                child: Transform.scale(
                  scale: 1,
                  child: Visibility(
                    visible: _visibleAddon,
                    child: Material(
                      type: MaterialType.circle,
                      color: widget.avatarSetting.canvasColor,
                      elevation: widget.avatarSetting.elevation,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (val) => {},
                        value: true,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _changeVisible() {
    if (!widget.visibleAdditionalControl) {
      setState(() {
        _visibleAddon = false;
      });
    }
  }
}

class ExAvatarSetting {
  final Size avatarSize;
  final Color backgroundColor;
  final Color canvasColor;
  final double elevation;
  final bool shadowOnContent;

  ExAvatarSetting({
    required this.avatarSize,
    required this.backgroundColor,
    required this.canvasColor,
    required this.elevation,
    required this.shadowOnContent,
  });
}
