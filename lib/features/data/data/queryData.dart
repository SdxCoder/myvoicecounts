


class QueryData{

  final QueryDataAgree agree;
  final QueryDataDisAgree disagree;
  final QueryDataUndecided undecided;

  QueryData({this.agree, this.disagree, this.undecided});

}

class QueryDataAgree{
  final Ethnicity ethnicity;
  final Race race;
  final Gender gender;
  final Party party;
  final Age age;

  QueryDataAgree({this.ethnicity, this.race, this.gender, this.party, this.age});
}


class QueryDataDisAgree{
  final Ethnicity ethnicity;
  final Race race;
  final Gender gender;
  final Party party;
  final Age age;

  QueryDataDisAgree({this.ethnicity, this.race, this.gender, this.party, this.age});
}


class QueryDataUndecided{
  final Ethnicity ethnicity;
  final Race race;
  final Gender gender;
  final Party party;
  final Age age;

  QueryDataUndecided({this.ethnicity, this.race, this.gender, this.party, this.age});
}

class Ethnicity{
  final int hisp;
  final int notHisp;

  Ethnicity({this.hisp, this.notHisp});
}


class Party{
  final int democrat;
  final int independent;
  final int republic;
  final int other;

  Party(this.democrat, this.independent, this.republic, this.other);
 
}


class Age{
  final int groupA;
  final int groupB;
  final int groupC;
  final int groupD;

  Age({this.groupA, this.groupB, this.groupC, this.groupD});

 
}


class Gender{
  final int male;
  final int female;

  Gender({this.male, this.female});
}

class Race{
  final int american;
  final int asian;
  final int african;
  final int hawaian;
  final int white;

  Race({this.american, this.asian, this.african, this.hawaian, this.white});
}
