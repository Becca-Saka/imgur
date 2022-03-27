import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

class FavoritesListItem extends StatelessWidget {
  final AccountController controller;
  const FavoritesListItem({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text("All Favorites",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            const SizedBox(
              width: 10,
            ),
            Text("Folders",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: appLightGrey)),
          ])),
      Expanded(
        child: controller.userFavouriteAlbums.isNotEmpty
            ? MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                padding: const EdgeInsets.all(6),
                itemCount: controller.userFavouriteAlbums.length,
                itemBuilder: (context, index) {
                  final albums = controller.userFavouriteAlbums[index];

                  return Card(
                    color: appBlack,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            getContentType(
                                albums.coverType, albums.coverLink, albums.coverHeight),
                            Padding(
                              padding:
                                  const EdgeInsets.all(8.0).copyWith(top: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(albums.title,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(Icons.arrow_upward,
                                          color: Colors.white, size: 16),
                                      Text(' ${albums.points??0} Points',
                                          style:
                                              TextStyle(color: appLightGrey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Visibility(
                              visible: albums.length != 0,
                              replacement: isVideo(albums.coverType)
                                  ? const Icon(
                                      Icons.videocam,
                                      color: Colors.white,
                                    )
                                  : const SizedBox.shrink(),
                              child: Visibility(
                                visible: albums.length > 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text('${albums.length}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    blurRadius: 25),
                                              ],
                                            )),
                                        Card(
                                          elevation: 8,
                                          color: Colors.transparent,
                                          shadowColor:
                                              Colors.black.withOpacity(0.6),
                                          child: const Icon(
                                            Icons.content_copy,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            )),
                      ],
                    ),
                  );
                },
              )
            :  Center(
                child: Text('No Albums',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: appLightGrey )),
              ),
      )
    ]);
  }
}
