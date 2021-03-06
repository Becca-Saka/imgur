import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

class ReArrageImagesView extends StatelessWidget {
  const ReArrageImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(builder: (context, controller, child) {
      return Scaffold(
        backgroundColor: appDeepBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appBlack,
          centerTitle: true,
          title: const Text('Re-arrange'),
          actions: [
            Center(
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
               Text('${controller.uploadTitle}?? No title',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Expanded(
                child: ReorderableListView(
                  children: controller.imagesToUploadMap
                      .map((e) => SizedBox(
                            key: UniqueKey(),
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                    width: 120,
                                    child: Image.file(
                                      File(e['image']),
                                      fit: BoxFit.cover,
                                    )),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: appBlack,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${e['controller'].text}',
                                              style: TextStyle(
                                                color: appLightGrey,
                                              ),
                                            )),
                                        Center(
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.dehaze)),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                  onReorder: controller.rearrangeFiles,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
