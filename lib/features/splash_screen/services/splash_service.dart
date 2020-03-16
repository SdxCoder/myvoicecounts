import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myvoicecounts/core/core.dart';
import '../data/user.dart';

class SplashService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _userCollection = Firestore.instance.collection(Db.usersCollection);

  User _currentUser;
  FirebaseUser _firebaseUser;

  FirebaseUser get firebaseUser => _firebaseUser;
  User get currentUser => _currentUser;
  void setUser(User user) {
    _currentUser = user;
  }

  Future addToAccounts(FirebaseUser user) async {
    await Firestore.instance
        .collection(Db.accountsDetails)
        .document(user.uid)
        .setData(
            {"accountCreatedAt": DateTime.now(), "accountStatus": "active"});
  }

  Future checkAccountStatus(FirebaseUser user) async {
    try {
      DocumentSnapshot snapshot = await Firestore.instance
          .collection(Db.accountsDetails)
          .document(user.uid)
          .get();

      if (snapshot.exists) {
        if (snapshot.data != null) {
          if (snapshot.data['accountStatus'] == "deleted") {
            return true;
          }
        }
      }

      return false;
    } catch (e) {
      return e.message;
    }
  }

  Future signInAnonymously() async {
    try {
      var authResult = await _firebaseAuth.signInAnonymously();

      await createUser(User(
        voteIntegrity: 3,
        isComplete: false,
        id: authResult.user.uid,
         integrity: 3));

      await _populateCurrentUser(authResult.user);

      return authResult.user;
    } catch (e) {
      return e.message;
    }
  }

  Future createUser(User user) async {
    DocumentSnapshot snapshot = await _userCollection.document(user.id).get();
    if (!snapshot.exists) {
      try {
        await _userCollection.document(user.id).setData(user.toJson());
      } catch (e) {
        return e.message;
      }
    }
  }

 

  Future getUser(String uid) async {
    try {
      var userData = await _userCollection.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _firebaseUser = user;
      _currentUser = await getUser(user.uid);
    }
  }
}
