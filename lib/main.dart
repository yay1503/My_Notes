import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import "package:my_notes/constants/routes.dart";
import "package:my_notes/views/login_view.dart";
import "package:my_notes/views/notes_view.dart";
import "package:my_notes/views/register_view.dart";
import "package:my_notes/views/verify_email_view.dart";
import "firebase_options.dart";
import "dart:developer" as devtools show log ;

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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
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
                  devtools.log("User is verified");
                }else {
                  return const VerifyEmailView();
                }
              }else{
                  return const LoginView();
              }
              return const NotesView();
          default :
            return const CircularProgressIndicator();

          }
            
        }
          
      );
  }
}



