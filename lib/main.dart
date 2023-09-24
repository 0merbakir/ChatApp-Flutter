import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();    // to start firebase features this code must be used
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,   // This line initializes Firebase for your Flutter app. Firebase is a
    // platform that provides various services like authentication, cloud storage, and a real-time database.
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177)),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),   // listening the auth state here
          builder: (ctx, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
            if(snapshot.hasData){
              return const ChatScreen();
            }
            return const AuthScreen();
          },
        ),
    );
  }
}
