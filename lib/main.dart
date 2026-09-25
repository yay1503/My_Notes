import 'package:flutter/material.dart';
import "package:my_notes/constants/routes.dart";
import "package:my_notes/services/auth/auth_service.dart";
import "package:my_notes/views/login_view.dart";
import "package:my_notes/views/notes_view.dart";
import "package:my_notes/views/register_view.dart";
import "package:my_notes/views/verify_email_view.dart";


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
        future: AuthService.firebase().intialize(),
        builder: (context, asyncSnapshot) {
          switch(asyncSnapshot.connectionState)
          {
            case ConnectionState.done :
              final user = AuthService.firebase().currentUser;
              if(user != null){
              if (user.isEmailVerified){
                  return const NotesView();
                }else {
                  return const VerifyEmailView();
                }
              }else{
                  return const LoginView();
              }
          default :
            return const CircularProgressIndicator();

          }
            
        }
          
      );
  }
}



