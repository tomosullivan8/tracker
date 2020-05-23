import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';

class TrackerImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Material(
        type: MaterialType.circle,
        color: Colors.grey[300],
        clipBehavior: Clip.antiAlias,
        child: Consumer<Cardinal>(
          builder: (context, cardinal, child) {
            return InkWell(
              onTap: cardinal.pickImage,
              child: Container(
                alignment: Alignment.center,
                height: kToolbarHeight * 2,
                width: kToolbarHeight * 2,
                decoration: BoxDecoration(
                  image: (cardinal.image != null)
                      ? DecorationImage(
                          image: FileImage(cardinal.image),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: cardinal.image == null ? Icon(Icons.image) : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
