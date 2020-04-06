
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Sfv extends Equatable{
  final String title;
  final String link;
  final String videoUrl;
  final String thumbnail;
  final String adminId;
  final int agree;
  final int disagree;
  final int undecided;
  final String _documentId;

  String get documentId => _documentId;

  Sfv( {this.agree, this.disagree, this.undecided,this.link, this.videoUrl,this.thumbnail, this.title, this.adminId, documentId}) : _documentId = documentId;

  Sfv.fromMap(Map<String, dynamic> map,  DocumentSnapshot snapshot) :
   
   this.title = map['title'],
   this.link = map['link'],
   this.videoUrl = map['videoUrl'],
   this.adminId = map['adminId'],
   this.agree = map['agree'],
   this.disagree = map['disagree'],
   this.undecided = map['undecided'],
   this.thumbnail = map['thumbnail'],
   this._documentId = snapshot.documentID;

  Map<String, dynamic> toMap(String id){
    return {
      'id': id,
      'title' : this.title,
      'link' : this.link,
      'videoUrl' : this.videoUrl,
      'adminId': this.adminId,
      'thumbnail' : this.thumbnail,
      'agree' :agree,
      'disagree': disagree,
      'undecided': undecided
    };
  }

  @override
  List<Object> get props => [
    title, link, videoUrl, adminId, _documentId, agree, disagree, undecided
  ];
}


class CloudStorageVideoResult {
  final String videoUrl;

  CloudStorageVideoResult({this.videoUrl});

  
}
