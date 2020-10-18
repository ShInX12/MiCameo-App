import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPreview extends StatefulWidget {
  final String url;
  final Function onTap;

  const VideoPreview({this.url, this.onTap});

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  Uint8List uint8list;

  @override
  void initState() {
    super.initState();
    getThumbnail();
  }

  getThumbnail() async {
    uint8list = await VideoThumbnail.thumbnailData(
      video: widget.url,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 256,
      quality: 90,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image(
            fit: BoxFit.cover,
            image: uint8list == null
                ? AssetImage('assets/img/loading_gif.gif')
                : MemoryImage(uint8list),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black26, blurRadius: 6, spreadRadius: 1),
          ],
        ),
      ),
    );
  }
}
