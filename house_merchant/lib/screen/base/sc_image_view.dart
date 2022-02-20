import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewScreenArgument {
  final String? title;
  final List<String>? images;
  const ImageViewScreenArgument({@required this.images, this.title});
}

class ImageViewScreen extends StatelessWidget {
  final ImageViewScreenArgument? params;

  const ImageViewScreen({this.params});

  @override
  Widget build(BuildContext context) {
    final title = params!.title ?? '';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          loadFailedChild: Center(
            child: Icon(Icons.error_outline, color: Colors.white),
          ),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider:
                  CachedNetworkImageProvider(params!.images!.elementAt(index)),
              initialScale: PhotoViewComputedScale.contained * 0.8,
            );
          },
          itemCount: params!.images!.length,
        ),
      ),
    );
  }
}
