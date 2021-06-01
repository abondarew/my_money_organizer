import 'package:flutter/material.dart';

class CardWithAvatar extends StatelessWidget {
  final Widget avatarChild;
  final Color avatarBackgroundColor;
  final Widget cardBody;
  final Function onTap;

  CardWithAvatar({Key key, @required this.avatarChild, @required this.avatarBackgroundColor, @required this.cardBody, this.onTap})
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
                    child: cardBody,
                    elevation: 5,
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildAvatar(),
                  )),
            ],
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget _buildAvatar() {
    return InkWell(
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
                    heroTag: 'pickColor',
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FittedBox(fit: BoxFit.fitWidth, child: Icon(Icons.color_lens_rounded)),
                    ),
                    onPressed: () => _onTap(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTap() {
    onTap();
  }
}
