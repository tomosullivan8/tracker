import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Credit extends StatelessWidget {
  final String url = 'https://www.freepik.com/free-photos-vectors/data';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: kToolbarHeight * 1.5,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Scaffold(
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        url,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    Builder(
                      builder: (context) => Material(
                        type: MaterialType.circle,
                        color: Colors.transparent,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.content_copy),
                          ),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: url));
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Text copied to clipboard...'),
                                action: SnackBarAction(
                                  label: 'CLOSE',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Text(
        'Vector'.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .caption
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
