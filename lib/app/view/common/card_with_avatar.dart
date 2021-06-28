import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymoneyorganizer/app/view/common/util/color_utils.dart';
import 'package:mymoneyorganizer/app/view/common/util/crossfade_animation.dart';

class CardWithAvatar extends StatelessWidget {
  final String avatarText;
  final Color? avatarBackgroundColor;
  final Widget cardBody;
  final VoidCallback? onTap;
  final Widget? buttonChild;
  final Color? buttonColor;

  final Size avatarSize = const Size(90, 90);

  CardWithAvatar(
      {Key? key,
      required this.avatarText,
      required this.avatarBackgroundColor,
      required this.cardBody,
      this.onTap,
      this.buttonChild,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      //padding: EdgeInsets.all(8),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Stack(
            children: [
              _buildAvatar(withShadow: true),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 60, 8, 8),
                    child: cardBody,
                  ),
                ),
              ),
              _buildAvatar(
                withShadow: false,
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: avatarBackgroundColor,
                    borderRadius: BorderRadius.circular(80),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset.fromDirection((3 * pi) / 8, 1),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 250),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(80),
                      onTap: onTap,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CrossFade<String>(
                            builder: (val) => Text(
                              val!,
                              style: TextStyle(
                                fontSize: 400,
                                fontWeight: FontWeight.bold,
                                color: ColorUtils.contrastText(avatarBackgroundColor!, Colors.grey.shade200, Colors.grey.shade800),
                              ),
                            ),
                            initialData: avatarText,
                            data: avatarText,
                            duration: Duration(milliseconds: 250),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.only(left: 16),
                child: SizedBox.fromSize(
                  size: avatarSize,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      onPressed: onTap,
                      shape: StadiumBorder(),
                      child: Icon(
                        Icons.color_lens_outlined,
                      ),
                      //color: Colors.blue,
                    ),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar({bool withShadow = false, Widget? child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox.fromSize(
        size: avatarSize,
        child: Container(
          //color: Colors.blue,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            boxShadow: withShadow
                ? [
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Colors.grey.shade400,
                      offset: Offset.fromDirection((3 * pi) / 8, 1),
                    ),
                  ]
                : null,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(4),
          child: child,
        ),
      ),
    );
  }
}
