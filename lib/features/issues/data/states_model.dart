


class TopStates {
  final int votes;
  final String state;
  final DateTime date;
  final String issueId;
  final String issueName;
  final String documentId;
 

  TopStates(
    {this.votes,
    this.state,
    this.date,
    this.issueId,
    this.issueName,
    documentId}
  ) : this.documentId = documentId;

  TopStates.fromMap(Map<String, dynamic> map, ) : 
    votes = map['votes'],
    state = map['state'],
    date = map['date'],
    issueName = map['issueName'],
    issueId = map['issueId'],
    documentId = map['id'];


   Map<String, dynamic> toMap(){
    return {
      'votes' : votes,
      'state' : state,
      'date' : date,
      'issueName' : issueName,
      'issueId' : issueId,
      'id': documentId
    };
  }
}
