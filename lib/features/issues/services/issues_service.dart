
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myvoicecounts/core/core.dart';

class IssuesService {
  final _firestore = Firestore.instance;

   Stream<QuerySnapshot> getIssuesStream(){
    return _firestore.collection(Db.issuesCollection).snapshots();
  }

}
