import 'package:flutter/cupertino.dart';

class TextWithLoader extends StatelessWidget {
  final String title;
  final bool isLoading;
  final double fontSize;

  TextWithLoader(
      {@required this.title, @required this.isLoading, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Text.rich(TextSpan(children: [
            WidgetSpan(child: CupertinoActivityIndicator()),
            WidgetSpan(child: SizedBox(width: 5)),
            TextSpan(
              text: 'Loading...',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ]))
        : Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
            ),
          );
  }
}
