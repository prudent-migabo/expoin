import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expoin/business_logic/business_logic.dart';
import 'package:expoin/constants.dart';
import 'package:expoin/data/data.dart';
import 'package:expoin/presentation/presentation.dart';
import 'package:expoin/utils/utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/UpdateProfileScreen';
   UpdateProfileScreen({Key? key, this.userName, this.userProfileImgUrl}) : super(key: key);
   String? userName;
   String? userProfileImgUrl;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
   final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final MesPiecesBloc _bloc = MesPiecesBloc();
   ProfileRepository repository = ProfileRepository();
   File? _pickedImage;
   String imgUrl = '';


   onSubmit(){
        getImageUrl().whenComplete(() {
         _bloc.add(UpdateUserInfoEvent(
           profileImgUrl: imgUrl,
           userName: widget.userName!,
         ));
       });
   }

   Future getImageUrl() async {
     imgUrl = await repository.getImageUrl(_pickedImage!);
     print('****************** profileImageUrl : $imgUrl');
   }


  @override
  Widget build(BuildContext context) {
    return BlocListener<MesPiecesBloc, MesPiecesState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is UserInformationUploaded) {
          successToast(message: 'Photo de profils modifié avec succes');
        } else if (state is ErrorState) {
          errorDialog(context, content: state.message);
        } else if (state is NoNetworkState) {
          noNetworkToast(context);
        }
        },
  child: Scaffold(
      body: SingleChildScrollView(
        padding: mainPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 15,
            ),
            AuthHeaderWithArrow(
              text: 'Modifier profils',
            ),
            SizedBox(
              height: 20,
            ),
            Text('Photo de profile', style: TextStyle(fontWeight: bold, fontSize: 16),),
            SizedBox(height: 15,),
            Stack(
              alignment: Alignment.center,
              children: [
                _pickedImage == null
                    ? widget.userProfileImgUrl == ''
                    ? Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Icon(Icons.person, size: 30,),
                ) : CachedNetworkImage(
                  imageUrl: widget.userProfileImgUrl!,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ):
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: FileImage(File(_pickedImage!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
                Positioned(
                  bottom: 10,
                  right: MediaQuery.of(context).size.width/4,
                  child: InkWell(
                      onTap: () async{
                        final picked = await getImageFromGallery();
                        setState(() {
                          _pickedImage = picked;
                        });
                        await getImageUrl();
                      },
                      child: const Icon(Icons.camera_alt, size: 30,),),),
              ],
            ),
            const SizedBox(height: 20,),
            Text('Nom', style: TextStyle(fontWeight: bold, fontSize: 16),),
            const SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                hintText: widget.userName ?? "Nom d'utilisateur",
                hintStyle: const TextStyle(color: Colors.blueGrey),
                suffixIcon: Icon(Icons.edit, size: 20,),
              ),
            ),
            SizedBox(height: 20,),
            BlocBuilder<MesPiecesBloc, MesPiecesState>(
              bloc: _bloc,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is LoadingState ? (){} : onSubmit,
                  child: Text(state is LoadingState
                      ? 'Patientez...'
                      : 'Mettre à jour'),
                );
              },
            ),
          ],
        ),
      ),
    ),
);
  }
}


