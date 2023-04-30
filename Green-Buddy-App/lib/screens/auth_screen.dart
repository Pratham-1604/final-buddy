import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //   final ref = FirebaseStorage.instance
        //       .ref()
        //       .child('user_image')
        //       .child('${authResult.user!.uid}.jpg');

        //   ref.putFile(image).whenComplete;

        //   final url = await ref.getDownloadURL();

        //   print("\n**URL**\n");
        //   print(url);
        //   print("\n**URL**\n");

        //   await FirebaseFirestore.instance
        //       .collection('/users')
        //       .doc(authResult.user!.uid)
        //       .set({
        //     'username': username,
        //     'email': email,
        //     'image_url': url,
        //   });

        print("user adding");
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${authResult.user!.uid}.jpg');
        ref.putFile(image).whenComplete(() async {
          final url = await ref.getDownloadURL();
          var users = FirebaseFirestore.instance.collection('users');
          users.doc(authResult.user!.uid).set({
            'username': username,
            'email': email,
            'image_url': url,
          });
          print("user added");
        });
      }

      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (error) {
      var message = 'An error occured, please check you credentials';

      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
