import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconDescriptionRowWidget extends StatelessWidget {

  final IconData rowIcon;
  final String description;
  final int fontSize;
  final int imageSize;

  const IconDescriptionRowWidget({Key key, @required this.rowIcon, @required this.description, this.fontSize, this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(
          rowIcon,
          size: imageSize ?? 12,
        ),
        const SizedBox(width: 20,),
        Flexible(
          child: new Text(description,
            style: TextStyle(
              fontSize: fontSize ?? 12,
            ),
          ),
        ),
      ],
    );
  }

}
