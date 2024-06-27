import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class CachedImage extends StatefulWidget {
  final String  img  ;
  final double? height ;
  final double? width;
  final BoxFit? box  ;
   CachedImage({super.key, required this.img,  this.height,  this.width,  this.box});

  @override
  State<CachedImage> createState() => _CahedImageState();
}

class _CahedImageState extends State<CachedImage> {
  set() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
      });
    });
    return Container() ;
  }
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: widget.height,
      width: widget.width,
      fit: widget.box,
      imageUrl:widget.img,
      errorWidget: (context, url, error) => set(),
    );
  }
}