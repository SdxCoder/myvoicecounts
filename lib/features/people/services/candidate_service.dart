


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myvoicecounts/core/core.dart';

class CandidateService {
  final _firestore = Firestore.instance;

 
  Stream<QuerySnapshot> getCandidatesStream(){
    return _firestore.collection(Db.candidatesCollection).snapshots();
  }

}
