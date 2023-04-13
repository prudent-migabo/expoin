import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/utils/utils.dart';
import 'package:provider/provider.dart';

class CarouselAdvertising extends StatelessWidget {
   CarouselAdvertising({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: StreamBuilder<List<ImageModel>>(
          stream: context.watch<ImagesRepository>().getListImages(),
          builder: (context, snapshot) {
            List<ImageModel>? listImages = snapshot.data;
            if(!snapshot.hasData || listImages!.isEmpty){
              return CachedNetworkImage(
                imageUrl: 'https://firebasestorage.googleapis.com/v0/b/expoin-94ae4.appspot.com/o/advertise%2Fimages%2FIMG-20221012-WA0195.jpg?alt=media&token=44613ade-52fd-486a-b043-f2313cf9225e',
                imageBuilder: (context, imageProvider) => Container(
                  height: 220.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              );
            } else if (snapshot.hasError){
              errorDialog(context, content: snapshot.error.toString());
            }
            return CarouselSlider.builder(itemCount: listImages.length,
              options: CarouselOptions(
                autoPlay: true,
                height: 220.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.96,
              ),
              itemBuilder: (BuildContext context, int index, int pageViewIndex){
                var data = listImages[index];
                return  CachedNetworkImage(imageUrl: data.imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            );
          }
      ),

    );
  }
}