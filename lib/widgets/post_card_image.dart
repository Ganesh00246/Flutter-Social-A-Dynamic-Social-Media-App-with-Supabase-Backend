import 'package:flutter/material.dart';

import '../models/post_model.dart';
import '../utils/helper.dart';
class PostCardImage extends StatelessWidget {
  final String url;
   PostCardImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height*0.60,
      maxWidth: MediaQuery.of(context).size.width*0.80,
    ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(getS3Url(url),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),

      ),
    );
  }
}
