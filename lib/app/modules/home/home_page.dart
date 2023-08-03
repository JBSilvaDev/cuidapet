import 'package:app_cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              
            },
          ),
      
        ],
        title: const Text('Home Page'),
      ),
      body: Container(
        child: ElevatedButton(onPressed: () async {
          final categoriesResponse = await Modular.get<RestClient>().auth().get('/categories/');
          print(categoriesResponse.data);


        }, child: Text('Teste Refresh Token')),
      ),
    );
  }
}
