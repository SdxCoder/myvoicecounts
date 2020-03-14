
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Candidate extends Equatable{
  final String name;
  final String party;
  final String imageUrl;
  final String adminId;
  final String _documentId;

  String get documentId => _documentId;

  Candidate({this.party, this.imageUrl, this.name, this.adminId, documnetId}) : _documentId = documnetId;

  Candidate.fromMap(Map<String, dynamic> map, DocumentSnapshot snapshot) :
   this.name = map['name'],
   this.party = map['party'],
   this.imageUrl = map['imageUrl'],
   this.adminId = map['adminId'],
   this._documentId = snapshot.documentID;

  Map<String, dynamic> toMap(String id){
    return {
      'id': id,
      'name' : this.name,
      'party' : this.party,
      'imageUrl' : this.imageUrl,
      'adminId': this.adminId
    };
  }

  @override
  List<Object> get props => [
    name, party, imageUrl, _documentId, adminId
  ];
}


class CloudStorageImageResult {
  final String imageUrl;

  CloudStorageImageResult({this.imageUrl});

  
}
