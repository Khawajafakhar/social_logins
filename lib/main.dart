import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map? userData;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Facebook (Logged  ${userData == null ? 'out' ')' : 'in' ')'}'),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final result = await FacebookAuth.i
                        .login(permissions: ["public_profile", "email"]);
                    if (result.status == LoginStatus.success) {
                      final requestData = await FacebookAuth.i.getUserData(
                        fields: "email, name",
                      );
                      setState(() {
                        userData = requestData;
                      });
                    }
                  },
                  child: const Text('Log in')),
              ElevatedButton(
                  onPressed: () async {
                    await FacebookAuth.i.logOut();

                    setState(() {
                      userData = null;
                    });
                  },
                  child: const Text('Log out')),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: userData == null
                    ? null
                    : Column(children: [
                        Text(userData!['email']),
                        Text(userData!['name'])
                      ]),
              ),
              ElevatedButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  try {
                 var result=   await googleSignIn.signIn();
                 print(result);
                  } catch (error) {
                    print(error);
                  }
                },
                child: const Text('google Sign in'),
              ),
            ]),
      ),
    );
  }
}
