import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expoin/models/models.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';

class AdvertisingContainer extends StatelessWidget {
  const AdvertisingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: StreamBuilder<List<ImageModel>>( 
        stream: context.watch<ImagesRepository>().getListImages(),
        builder: (context, snapshot) {
          List<ImageModel>? listImages = snapshot.data;
          if(!snapshot.hasData || listImages!.isEmpty){
            return Center(child: Text("Pas encore d'information"),);
          }
          return CarouselSlider.builder(itemCount: listImages.length,
            options: CarouselOptions(
              height: 220.0,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
            //  viewportFraction: 0.8,
            ),
              itemBuilder: (BuildContext context, int index, int pageViewIndex){
            var data = listImages[index];
            return  CachedNetworkImage(imageUrl: data.imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
