// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify/utilities/jso_response.dart';

import '../utilities/authentication.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25,),
              ClipOval(

                child: getProfileImage(),
              ),
              Text("Bienvenido, ${FirebaseAuth.instance.currentUser!.displayName!}", style: const TextStyle(fontSize: 24),),
              const SizedBox(height: 20,),
              const Text("Nombre de la playlist: ", style: TextStyle(fontSize: 20),),
              const SizedBox(height: 10,),
              Text("${response["playlist_name"]}", style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: getCanciones(),
                ),
              ),
              const SizedBox(height: 15,),
              OutlineButton.icon(
                label: const Text("Cerrar sesión", style: TextStyle(fontSize: 16),),
                onPressed: () {
                  Authentication.signOut(context: context);
                  Navigator.pushReplacementNamed(context, 'login');
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
        )
      ),
    );
  }

  getProfileImage(){
    if(FirebaseAuth.instance.currentUser!.photoURL!=null){
      return Image.network(FirebaseAuth.instance.currentUser!.photoURL!, height: 100, width: 100, fit: BoxFit.cover,);

  }
  else{
    return const Icon(Icons.account_circle, size: 100,);
    }
  }


  getCanciones(){
    List<Canciones> listaCanciones = [];
    response["items"].forEach((value) {
      listaCanciones.add(
        Canciones(
        urlImage: value["track"]["album"]["images"][0]["url"],
        nombreCancion: value["track"]["name"],
        nombreArtistas: value["track"]["artists"].map((value) => value["name"]).toList(),
      ));


    });
    return listaCanciones;


  }


}






class Canciones extends StatelessWidget {
  final String urlImage;
  final String nombreCancion;
  final List nombreArtistas;
  const Canciones({ Key? key, required this.urlImage, required this.nombreCancion, required this.nombreArtistas }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String artistas = nombreArtistas.join(", ");


    return Row(
      children: [
        const SizedBox(width: 5,),
        Container(
          width: 150,
          child: Column(
            children: [
              Image.network(urlImage, height: 150, width: 150, fit: BoxFit.cover,),
              const SizedBox(height: 10,),
              Text(nombreCancion, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.normal), maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 10,),
              Text(artistas, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),maxLines: 1, overflow: TextOverflow.ellipsis,),
            ],
            
          ),
        ),
        const SizedBox(width: 5,),
      ],
    );
  }
}