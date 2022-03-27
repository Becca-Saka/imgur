import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';

class UploadView extends StatelessWidget {
  const UploadView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(builder: (context, controller, child) {
      return WillPopScope(
        onWillPop: () async {
          /// stops the user from going back or closing th page while uploading
          if (controller.state == AppState.busy) {
            return false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView(
                  children: [
                    const SizedBox(height: kToolbarHeight + 15),
                    ColoredBox(
                      color: appBlack,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: controller.onTitleChanged ,
                                    decoration: InputDecoration(
                                        hintText: 'Post title(optional)',
                                        hintStyle:
                                            TextStyle(color: appDarkGrey),
                                        
                                        border: InputBorder.none),
                                  ),
                                ),
                                PopupMenuButton(
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                    onSelected: (String index) =>
                                        controller.navigateToRearrange(),
                                    itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(
                                          value: 'rearage',
                                          child: Text('Re-arrange images'),
                                        ),
                                      ];
                                    }),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  ImgurIconPack.eyeClosed,
                                  color: appLightGrey,
                                ),
                                RichText(
                                    text: TextSpan(
                                  text: '  Your post will upload as ',
                                  style: TextStyle(color: appLightGrey),
                                  children: const [
                                    TextSpan(
                                      text: 'Hidden',
                                      style: TextStyle(
                                          color: Color(0xFF4caf50),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                   
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final image = controller.imagesToUploadMap[index];

                        return ImageItem(
                          imagePath: image['image'],
                          controller: image['controller'],
                        );
                      },
                      itemCount: controller.imagesToUploadMap.length,
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: appDarkGrey,
                          // elevation: 2,
                          side: const BorderSide(color: Colors.white),
                        ),
                        onPressed: controller.pickMoreFiles,
                        child: const Text('+ Add Image and Videos')),
                    const SizedBox(height: 15),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'By uploading, you agree to our ',
                            style: TextStyle(
                              fontSize: 14,
                              color: appLightGrey,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Terms of Service',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ])),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  color: appBlack,
                  height: kToolbarHeight + MediaQuery.of(context).padding.top,
                  child: SafeArea(
                    child: Visibility(
                      visible: controller.state == AppState.busy,
                      child: LinearProgressIndicator(
                        minHeight: 80,
                        backgroundColor: appGreen,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            appBlack.withOpacity(0.4)),
                      ),
                      replacement: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              controller.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (controller.uploadedFeed != null) {
                                controller.viewUploadedFeed();
                              } else {
                                controller.uploadFiles();
                              }
                            },
                            child: Container(
                              color: appGreen,
                              width: 80,
                              child: Center(
                                child: Text(
                                  controller.uploadedFeed != null
                                      ? 'View'
                                      : 'Upload',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ImageItem extends StatelessWidget {
  final String imagePath;
  final TextEditingController controller;
  const ImageItem({Key? key, required this.imagePath, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF424242),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.file(File(imagePath)),
              ColoredBox(
                color: appBlack,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Add a description',
                      hintStyle: TextStyle(color: appDarkGrey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
