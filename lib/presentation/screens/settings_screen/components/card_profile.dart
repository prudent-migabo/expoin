import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CardProfile extends StatelessWidget {
  CardProfile({
    super.key,
  });

  final ProfileRepository _repository = ProfileRepository();
  String? userImgUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        child: StreamBuilder<UserModel>(
          stream: _repository.getUserModel(),
          builder: (context, snapshot) {
            UserModel? userModel = snapshot.data;
            if (!snapshot.hasData){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200]
                ),
                child: const Icon(Icons.person, size: 30,),
              ),
                  Text('Votre nom', style: TextStyle(fontSize: 20, fontWeight: bold),),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Votre adresse mail', style: TextStyle(color: Colors.grey),),
                  SizedBox(
                    height: 15,
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(

                            )));
                          },
                          icon: Icon(Icons.arrow_back_ios, size: 13,),
                          label: Text(
                            'Modifier profils',
                            style: GoogleFonts.dmSans(fontWeight: bold),
                          ))),

                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userModel!.profileImgUrl! != '' ? CachedNetworkImage(
                  imageUrl: userModel.profileImgUrl!,
                  imageBuilder: (context, imageProvider){
                    userImgUrl = userModel.profileImgUrl;
                    return  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ) : Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200]
                  ),
                  child: const Icon(Icons.person, size: 30,),
                ),
                SizedBox(height: 10,),
                Text(userModel.lastName!, style: TextStyle(fontSize: 20, fontWeight: bold),),
                SizedBox(
                  height: 5,
                ),
                Text(userModel.email!, style: TextStyle(color: Colors.grey),),
                SizedBox(
                  height: 15,
                ),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen(
                            userName: userModel.lastName,
                            userProfileImgUrl: userModel.profileImgUrl,
                          )));
                        },
                        icon: Icon(Icons.arrow_back_ios, size: 13,),
                        label: Text(
                          'Modifier profils',
                          style: GoogleFonts.dmSans(fontWeight: bold),
                        ))),

              ],
            );
          }
        ),
      ),
    );
  }
}