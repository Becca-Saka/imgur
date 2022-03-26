import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/ui/widgets/video_thumbnail.dart';
//TODO: Add title and lenght to album
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text(
                  "WhatsApp type sliver appbar",
                ),
                expandedHeight: 150.0,
                backgroundColor: Colors.green,
                centerTitle: true,
                pinned: true,
                floating: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.compare_arrows),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
                bottom: TabBar(
                    indicatorColor: Colors.black,
                    labelPadding: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    tabs: [
                      Text("Posts"),
                      Text("Favorites"),
                      Text("Comments"),
                    ]),
              ),
            ];
          },
          body: TabBarView(
            children: [
              const Center(
                child: Text('Display Tab 1',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Center(
                child: Text('Display Tab 2',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Center(
                child: Text('Display Tab 3',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ProleListItem extends StatelessWidget {
  final FeedController controller;
  const ProleListItem({ Key? key, required this.controller }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: controller.currentUser.albums?.length,
      itemBuilder: (context, index) {
        final albums = controller.currentUser.albums![index];
        
        return Card(
          color: appBlack,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getContentType(albums.coverType, albums.imgurAlbumLink,),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text('${albums.title}',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 10),
                        const Text('135',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Visibility(
                  // visible: album != null ,
                  // && be.images!.length > 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isVideo(albums.coverType)
                        ? const Icon(
                            Icons.videocam,
                            color: Colors.white,
                          )
                        : Row(
                            children: [
                              Text('{be.images!.length}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.6),
                                          blurRadius: 25),
                                    ],
                                  )),
                              Card(
                                elevation: 8,
                                color: Colors.transparent,
                                shadowColor: Colors.black.withOpacity(0.6),
                                child: const Icon(
                                  Icons.content_copy,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  bool isVideo(String type) => type.startsWith('video/');
  bool isImage(String type) => type.startsWith('image/');
Widget getContentType(String type, String url,) {
    final imageHeight = 350.toDouble();

    if (isImage(type)) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        height: imageHeight,
      );
    } else if (isVideo(type)) {
      return VideoThumbNailItem(
        url: url,
        height: imageHeight,
      );
    }
    return const SizedBox.shrink();
  }
}
