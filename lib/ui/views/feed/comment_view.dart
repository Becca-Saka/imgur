import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/ui/widgets/cont_widget.dart';

class CommentView extends StatelessWidget {
  final FeedModel feed;
  const CommentView({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(
      builder: (context, controller, child) {
        return Scaffold(
          backgroundColor: appDeepBlack,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Original Post',
                          style: TextStyle(color: appLightGrey, fontSize: 12)),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8)
                          .copyWith(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 80,
                              height: 80,
                              child: getContentType(
                                  feed.images!.first.type!,
                                  feed.images!.first.link!,
                                  feed.images!.first.height)),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${feed.title}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              RichText(
                                  text: TextSpan(
                                text: 'By ',
                                style: TextStyle(color: appLightGrey, fontSize: 12),
                                children: [
                                  TextSpan(
                                    text: '${feed.feedAuthor}',
                                    style: const TextStyle(color: Colors.purple),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: appLightGrey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: controller.commentController,
                        style: const TextStyle(color: Colors.white) ,
                        decoration: InputDecoration(
                          hintText: 'Commenting as ${controller.user.username} ',
                          hintStyle: TextStyle(color: appLightGrey),
                          
                          focusColor: appGreen,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: appGreen, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                    height: 80,
                    decoration: BoxDecoration(
                      color: appBlack,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'GIF',
                          style: TextStyle(
                            color: appLightGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Icon(
                          Icons.favorite,
                          color: appLightGrey,
                        ),
                        const Spacer(),
                        Text(
                          '0/140',
                          style: TextStyle(
                            color: appLightGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                           log('clicked');
                           
                            // final controller = locator<FeedController>();
                            await controller.makeComment(feed);
                            } catch (e) {
                              print(e);
                            }
                          },
                          icon: const Icon(Icons.send),
                          color: appLightGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
