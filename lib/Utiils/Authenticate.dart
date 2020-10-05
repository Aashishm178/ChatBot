import 'package:chatbot/Constants/Constants.dart';
import 'package:chatbot/Utiils/Networking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Networking networking = Networking();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final Firestore _firestore = Firestore.instance;
  Future<bool> addUserEmailAndPassword(String email, String password) async {
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        var snapshot = await _firestore
            .collection('users')
            .document(user.uid)
            .collection('FcmToken')
            .document(user.uid)
            .get();
        if (!snapshot.exists) {
          var token = await _firebaseMessaging.getToken();
          if (token != null) {
            await networking.addToken(token, user.uid);
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> facebookLogin() async {
    try {
      final FacebookLoginResult result = await _facebookLogin.logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);
          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;
          if (user != null) {
            var snapshot = await _firestore
                .collection('users')
                .document(user.uid)
                .collection('FcmToken')
                .document(user.uid)
                .get();
            if (!snapshot.exists) {
              var token = await _firebaseMessaging.getToken();
              if (token != null) {
                await networking.addToken(token, user.uid);
              }
            }
            return {'User': user, 'success': true};
          } else {
            return {'success': false};
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('cancelled');
          return {'success': false};
          break;
        case FacebookLoginStatus.error:
          print(result.errorMessage);
          return {'success': false};
          break;
        default:
          return {'success': false};
          break;
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Map<String, dynamic>> gmailLogin() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      try {
        final GoogleSignInAuthentication authentication =
            await account.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: authentication.idToken,
            accessToken: authentication.accessToken);
        try {
          final FirebaseUser user =
              (await _auth.signInWithCredential(credential)).user;
          assert(user.email != null);
          assert(user.displayName != null);
          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);
          try {
            final FirebaseUser currentUser = await _auth.currentUser();
            assert(user.uid == currentUser.uid);
            if (user != null) {
              var snapshot = await _firestore
                  .collection('users')
                  .document(user.uid)
                  .collection('FcmToken')
                  .document(user.uid)
                  .get();
              if (!snapshot.exists) {
                var token = await _firebaseMessaging.getToken();
                if (token != null) {
                  await networking.addToken(token, user.uid);
                }
              }
              return {'User': user, 'success': true};
            } else {
              return {'success': false};
            }
          } catch (firebaseUserError) {
            print(firebaseUserError);
            print('1');
            throw firebaseUserError;
          }
        } catch (firebaseSignInError) {
          print(firebaseSignInError);
          print('2');
          throw firebaseSignInError;
        }
      } catch (authenticateError) {
        print(authenticateError);
        print('3');
        throw authenticateError;
      }
    } catch (googleSignError) {
      print(googleSignError);
      print('4');
      throw googleSignError;
    }
  }

  Future<Map<String, dynamic>> twitterLogin() async {
    TwitterLogin twitterLogin =
        TwitterLogin(consumerKey: key, consumerSecret: secretKey);
    try {
      TwitterLoginResult twitterLoginResult = await twitterLogin.authorize();
      switch (twitterLoginResult.status) {
        case TwitterLoginStatus.loggedIn:
          var session = twitterLoginResult.session;
          final AuthCredential credential = TwitterAuthProvider.getCredential(
              authToken: session.token, authTokenSecret: session.secret);
          try {
            final FirebaseUser user =
                (await _auth.signInWithCredential(credential)).user;
            if (user != null) {
              var snapshot = await _firestore
                  .collection('users')
                  .document(user.uid)
                  .collection('FcmToken')
                  .document(user.uid)
                  .get();
              if (!snapshot.exists) {
                var token = await _firebaseMessaging.getToken();
                if (token != null) {
                  await networking.addToken(token, user.uid);
                }
              }
              return {'User': user, 'success': true};
            } else {
              return {'success': false};
            }
          } catch (error) {
            print(error);
            throw error;
          }
          break;
        case TwitterLoginStatus.cancelledByUser:
          return {'success': false};
          break;
        case TwitterLoginStatus.error:
          print(twitterLoginResult.errorMessage);
          return {'success': false};
          break;
        default:
          return {'success': false};
          break;
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<Map<String, dynamic>> authenticateFirebaseUser(
      String username, String password) async {
    try {
      final AuthResult result = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        return {'User': user, 'success': true};
      } else {
        return {'success': false};
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
