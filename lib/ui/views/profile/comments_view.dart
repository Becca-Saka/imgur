import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

class CommentListView extends StatelessWidget {
  final AccountController controller;
  const CommentListView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.userComments.isNotEmpty
        ? ListView.builder(
            itemCount: controller.userComments.length,
            padding: const EdgeInsets.all(2),
            itemBuilder: (context, index) {
              final commentItem = controller.userComments[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8)
                    .copyWith(bottom: 10, top: 10),
                child: Row(
                  children: [
                    SizedBox(
                        width: 80,
                        height: 80,
                        child: getContentType(commentItem.coverType!,
                            commentItem.coverLink!, 80)),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${commentItem.comment}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_outlined,
                              color: appLightGrey,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                            Text('${commentItem.points ?? 0}',
                                style: TextStyle(
                                    color: appLightGrey, fontSize: 13)),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.access_time,
                              color: appLightGrey,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                            Text(
                                readTimeStampDaysOnly(
                                    int.parse(commentItem.date!) ~/ 1000),
                                style: TextStyle(
                                    color: appLightGrey, fontSize: 13))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            })
        :  Center(
            child: Text('No Comments',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: appLightGrey )),
          );
  }
}
