import 'package:flutter/material.dart';

class CardWithAvatar extends StatelessWidget {
  final Widget avatarChild;
  final Color? avatarBackgroundColor;
  final Widget cardBody;
  final VoidCallback? onTap;
  final Widget? buttonChild;
  final Color? buttonColor;

  CardWithAvatar(
      {Key? key,
      required this.avatarChild,
      required this.avatarBackgroundColor,
      required this.cardBody,
      this.onTap,
      this.buttonChild,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 90,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(4, 48, 4, 4),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 56, 16, 16),
                      child: cardBody,
                    ),
                    elevation: 5,
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildAvatar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 90,
        width: 100,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: avatarBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: avatarChild,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(1, .7),
              child: Container(
                width: 42,
                height: 42,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FloatingActionButton(
                    backgroundColor: buttonColor,
                    heroTag: 'pickColor',
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: buttonChild,
                      ),
                    ),
                    onPressed: onTap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
