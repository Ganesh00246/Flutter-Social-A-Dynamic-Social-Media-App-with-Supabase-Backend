import 'package:clone/models/reply_model.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:clone/widgets/reply_card_top_bar.dart';
import 'package:flutter/material.dart';
class ReplyCard extends StatelessWidget {
  final ReplyModel reply;
  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.12,
              child: CircleImage(
                url: reply.user?.metadata?.image,
              ),
            ),
            const SizedBox(width: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReplyCardTopBar(reply: reply),
                  Text(reply.reply!)
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        )
      ],
    );
  }
}
