import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/core.dart';

class SfvService{
   final _firestore = Firestore.instance;


  Stream<QuerySnapshot> getSfvStream(){
    return _firestore.collection(Db.sfvCollection).snapshots();
  }

  Future getSfvSnapshots() async {
    
    try{
      QuerySnapshot snapshot = await  _firestore.collection(Db.sfvCollection).getDocuments();
      return snapshot.documents;
    }
    catch(e){
      return e.message;
    }
    
  }

}