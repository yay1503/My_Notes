import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import "firebase_options.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(  
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false ,
      ),
      home: const HomePage(),
    ),);
}

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text("Home"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  ),
        builder: (context, asyncSnapshot) {
          switch(asyncSnapshot.connectionState)
          {
            case ConnectionState.done :
              return const Text("Done");

          default :
            return const Text ("Loading");

          }
            
        }
          
      )
    );
  }
}