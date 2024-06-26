import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kameti_app/Local/PrefManager.dart';
import 'package:kameti_app/model/auth_model/user_data_model.dart';
import 'package:kameti_app/screens/auth_screen/login_screen.dart';
import 'package:kameti_app/utils/Extensions.dart';

class AuthenticationProvider extends ChangeNotifier {
  static bool _isPassVisibleLogin = false;
  bool get isPassVisibleLogin => _isPassVisibleLogin;
  static bool _isPassVisibleSignUp = false;
  bool get isPassVisibleSignUp => _isPassVisibleSignUp;
  static bool _isConfirmPassVisible = false;
  bool get isConfirmPassVisible => _isConfirmPassVisible;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get firebaseAuth => _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;
  CollectionReference? collectionRef;
  DocumentSnapshot? docSnapshot;
  static User? _firebaseUser;
  User? get firebaseUser => _firebaseUser;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static final UserDataModel _userData = UserDataModel();
  UserDataModel get userData => _userData;
  static GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  static bool _isLoading = false;
  bool get isLoading => _isLoading;
  static bool _isAdmin = true;
  bool get isAdmin => _isAdmin;
  static bool _isDataUpLoading = false;
  bool get isDataUpLoading => _isDataUpLoading;

  setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }

  setDataUpLoading(bool value) async {
    _isDataUpLoading = value;
    notifyListeners();
  }

  void setPassVisibilityLogin() {
    _isPassVisibleLogin = !_isPassVisibleLogin;
    notifyListeners();
  }

  void setPassVisibilitySignUp() {
    _isPassVisibleSignUp = !_isPassVisibleSignUp;
    notifyListeners();
  }

  void setConfirmPassVisibility() {
    _isConfirmPassVisible = !_isConfirmPassVisible;
    notifyListeners();
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      setLoading(true);
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      PrefManager().saveUser();
      checkIsAdmin();
      setLoading(false);

      return cred.user;
    } catch (e) {
      setLoading(false);
      log(e.toString());
      e.toString().successSnack;
      "Something went wrong".errorSnack;
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      setLoading(true);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await PrefManager().saveUser();
      checkIsAdmin();
      setLoading(false);
    } catch (e) {
      setLoading(false);
      log(e.toString());
      e.toString().errorSnack;
      "Something went wrong".errorSnack;
    }
    return null;
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      setLoading(true);
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      setLoading(false);
      Get.back();
      "Password sent to your email".successSnack;
    } catch (e) {
      setLoading(false);
      log(e.toString());
      "Something went wrong".errorSnack;
    }
  }

  Future<User?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      "Sign Out Successfully".successSnack;
      const LoginScreen().navigate;
    } catch (e) {
      log(e.toString());
      "Something went wrong".errorSnack;
    }
    return null;
  }

  createAdmin(bool createAdmin) async {
    try {
      setLoading(true);
      _firestore.collection("users").doc(firebaseAuth.currentUser?.uid).update({
        "isAdmin": createAdmin,
      }).then((value) {
        "create New Admin successfully".successSnack;
        setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      setLoading(false);
      log(e.toString());
      e.toString().errorSnack;
    }
  }

  Future<bool> checkUserDetails() async {
    await init();
    docSnapshot = await collectionRef!.doc(_firebaseUser?.uid).get();
    log("the user details is $_userData && the ${_firebaseUser?.displayName}");
    if (docSnapshot != null && docSnapshot!.exists) {
      return true;
    } else {
      return false;
    }
  }

  init() {
    _firebaseUser = _firebaseAuth.currentUser;
    log("the firebase user $firebaseUser");
    collectionRef = _firestore.collection(AppKeys.userFirestoreCollectionKey);
    notifyListeners();
  }

  Future<bool> sendData(String email, fullName, phoneNumber, cnicNumber) async {
    setDataUpLoading(true);
    if (_firebaseAuth.currentUser?.uid != null ||
        _firebaseAuth.currentUser!.uid.isNotEmpty) {
      UserDataModel userData = UserDataModel(
        email: email,
        fullName: fullName,
        cnicNumber: cnicNumber,
        phoneNumber: phoneNumber,
        userId: _firebaseAuth.currentUser?.uid,
      );
      try {
        init();
        await collectionRef?.doc(_firebaseUser?.uid).set(userData.toMap());
        setDataUpLoading(false);
        return true;
      } catch (e) {
        setDataUpLoading(false);
        rethrow;
      }
    } else {
      "User detail is null".errorSnack;
      return false;
    }
  }

  checkIsAdmin() async {
    final record = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    _isAdmin = record["isAdmin"];
    log(_isAdmin.toString());
  }
}

class AppKeys {
  static String userFirestoreCollectionKey = "users";
}
