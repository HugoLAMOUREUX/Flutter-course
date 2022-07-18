import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';

enum StateRegistration {
  COMPLETE,
  IN_PROGRESS,
}

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<UserModel> get user {
    return _auth.authStateChanges().asyncMap((user) => UserModel.b(
          uid: user!.uid,
          email: user.email.toString(),
        ));
  }

  Future<UserModel> auth(UserModel userModel) async {
    print(userModel.toJson());
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
    } catch (e) {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      await mailinglist(userModel.email, StateRegistration.COMPLETE);
    }

    userModel.setUid = userCredential.user!.uid;
    return userModel;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<StateRegistration> mailinglist(
      String email, StateRegistration stateRegistration) async {
    DocumentReference documentReference =
        _firebaseFirestore.collection('mailinglist').doc(email);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (stateRegistration == StateRegistration.IN_PROGRESS) {}

    if (documentSnapshot.exists) {
      String state = documentSnapshot.get('state');
      StateRegistration.values
          .firstWhere((element) => element.toString() == state);
    }
    await documentReference.set({
      "state": StateRegistration.IN_PROGRESS.toString(),
    });
    return StateRegistration.IN_PROGRESS;
  }
}
