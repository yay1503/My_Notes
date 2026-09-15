import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import "package:my_notes/views/login_view.dart";
import "package:my_notes/views/register_view.dart";
import "package:my_notes/views/verify_email_view.dart";
import "firebase_options.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(  
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 3, 103, 244)),
        useMaterial3: false ,
      ),
      home: const HomePage(),
      routes : {
        "/login/" : (context) => const LoginView(),
        "/register/" : (context) => const RegisterView(),
      }
    ),);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  ),
        builder: (context, asyncSnapshot) {
          switch(asyncSnapshot.connectionState)
          {
            case ConnectionState.done :
              final user = FirebaseAuth.instance.currentUser ;
              if(user != null){
                if (user.emailVerified){
                  print("User is verified");
                }else {
                  return const VerifyEmailView();
                }
              }else{
                  return const LoginView();
              }
              return const Text("Done");
          default :
            return const CircularProgressIndicator();

          }
            
        }
          
      );
  }
}
