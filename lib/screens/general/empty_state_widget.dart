import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;

  const EmptyStateWidget({Key key, this.onPressed, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 100.0),
      child: Center(
        child: Column(
          children: [
            Text(this.message),
            TextButton(
              onPressed: this.onPressed,
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
