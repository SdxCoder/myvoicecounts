import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Issue extends Equatable{
  final String issueName;
  final String _documentId;
  final String adminId;

  String get documentId => _documentId;

  Issue({this.issueName,  this.adminId, documentId}) : _documentId = documentId;

  Issue.fromMap(Map<String, dynamic> map, DocumentSnapshot snapshot)
      : this.issueName = map['issueName'],
        this.adminId = map['adminId'],
      this._documentId = snapshot.documentID;

  Map<String, dynamic> toMap(String id) {
    return {
      'id' : id,
      'issueName': this.issueName,
      'adminId': this.adminId
    };
  }

  @override
  List<Object> get props => [
    issueName,adminId, _documentId
  ];
}
