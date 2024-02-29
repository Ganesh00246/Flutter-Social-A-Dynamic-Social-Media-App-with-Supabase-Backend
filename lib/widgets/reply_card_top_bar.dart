import 'package:clone/models/reply_model.dart';
import 'package:flutter/material.dart';

import '../utils/helper.dart';
class ReplyCardTopBar extends StatelessWidget {
  final ReplyModel reply;
  const ReplyCardTopBar({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(reply.user!.metadata!.name! ,style: const TextStyle(fontWeight: FontWeight.bold),),
        Row(
          children: [
            Text(formateDateFromNow(reply.createdAt!)),
            const SizedBox(width: 10,),
            const Icon(Icons.more_horiz)
          ],
        )
      ],
    );
  }
}
