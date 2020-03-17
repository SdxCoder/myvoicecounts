


class QueryData{

   QueryDataAgree agree;
   QueryDataDisAgree disagree;
   QueryDataUndecided undecided;
   int total;

  QueryData({this.agree, this.disagree, this.undecided, this.total});

}

class QueryDataAgree{
   int hisp;
   int notHisp;
   int american;
   int asian;
   int african;
   int hawaian;
   int white;
   int male;
   int female;
   int democrat;
   int independent;
   int republic;
   int other;
   int groupA;
   int groupB;
   int groupC;
   int groupD;

  //  Ethnicity ethnicity;
  //  Race race;
  //  Gender gender;
  //  Party party;
  //  Age age;

  QueryDataAgree({
   this.hisp,
   this.notHisp,
   this.american,
   this.asian,
   this.african,
   this.hawaian,
   this.white,
   this.male,
   this.female,
   this.democrat,
   this.independent,
   this.republic,
   this.other,
   this.groupA,
   this.groupB,
   this.groupC,
   this.groupD,
  });

  void calculatePercent(int total){
    print('Total : $total');
    groupA = ((groupA / total) * 100).toInt();
    groupB = ((groupB / total) * 100).toInt();
    groupC = ((groupC / total) * 100).toInt();
    groupD = ((groupD / total) * 100).toInt();

    democrat = ((democrat / total) * 100).toInt();
    independent = ((independent / total) * 100).toInt();
    republic = ((republic / total) * 100).toInt();
    other = ((other / total) * 100).toInt();

    american = ((american / total) * 100).toInt();
    hawaian = ((hawaian / total) * 100).toInt();
    african = ((african / total) * 100).toInt();
    asian = ((asian / total) * 100).toInt();
    white = ((white / total) * 100).toInt();

    male = ((male / total) * 100).toInt();
    female = ((female / total) * 100).toInt();

    hisp = ((hisp / total) * 100).toInt();
    notHisp = ((notHisp / total) * 100).toInt();
  }
}


class QueryDataUndecided{
   int hisp;
   int notHisp;
   int american;
   int asian;
   int african;
   int hawaian;
   int white;
   int male;
   int female;
   int democrat;
   int independent;
   int republic;
   int other;
   int groupA;
   int groupB;
   int groupC;
   int groupD;
  //  Ethnicity ethnicity;
  //  Race race;
  //  Gender gender;
  //  Party party;
  //  Age age;

  QueryDataUndecided({
    this.hisp,
   this.notHisp,
   this.american,
   this.asian,
   this.african,
   this.hawaian,
   this.white,
   this.male,
   this.female,
   this.democrat,
   this.independent,
   this.republic,
   this.other,
   this.groupA,
   this.groupB,
   this.groupC,
   this.groupD,
  });

   void calculatePercent(int total){
    groupA = ((groupA / total) * 100).toInt();
    groupB = ((groupB / total) * 100).toInt();
    groupC = ((groupC / total) * 100).toInt();
    groupD = ((groupD / total) * 100).toInt();

    democrat = ((democrat / total) * 100).toInt();
    independent = ((independent / total) * 100).toInt();
    republic = ((republic / total) * 100).toInt();
    other = ((other / total) * 100).toInt();

    american = ((american / total) * 100).toInt();
    hawaian = ((hawaian / total) * 100).toInt();
    african = ((african / total) * 100).toInt();
    asian = ((asian / total) * 100).toInt();
    white = ((white / total) * 100).toInt();

    male = ((male / total) * 100).toInt();
    female = ((female / total) * 100).toInt();

    hisp = ((male / total) * 100).toInt();
    notHisp = ((female / total) * 100).toInt();
  }
}


class QueryDataDisAgree{
   int hisp;
   int notHisp;
   int american;
   int asian;
   int african;
   int hawaian;
   int white;
   int male;
   int female;
   int democrat;
   int independent;
   int republic;
   int other;
   int groupA;
   int groupB;
   int groupC;
   int groupD;
  //  Ethnicity ethnicity;
  //  Race race;
  //  Gender gender;
  //  Party party;
  //  Age age;

  QueryDataDisAgree({
    this.hisp,
   this.notHisp,
   this.american,
   this.asian,
   this.african,
   this.hawaian,
   this.white,
   this.male,
   this.female,
   this.democrat,
   this.independent,
   this.republic,
   this.other,
   this.groupA,
   this.groupB,
   this.groupC,
   this.groupD,
  });

   void calculatePercent(int total){
    groupA = ((groupA / total) * 100).toInt();
    groupB = ((groupB / total) * 100).toInt();
    groupC = ((groupC / total) * 100).toInt();
    groupD = ((groupD / total) * 100).toInt();

    democrat = ((democrat / total) * 100).toInt();
    independent = ((independent / total) * 100).toInt();
    republic = ((republic / total) * 100).toInt();
    other = ((other / total) * 100).toInt();

    american = ((american / total) * 100).toInt();
    hawaian = ((hawaian / total) * 100).toInt();
    african = ((african / total) * 100).toInt();
    asian = ((asian / total) * 100).toInt();
    white = ((white / total) * 100).toInt();

    male = ((male / total) * 100).toInt();
    female = ((female / total) * 100).toInt();

    hisp = ((male / total) * 100).toInt();
    notHisp = ((female / total) * 100).toInt();
  }
  
}



// class QueryDataDisAgree{

//    Ethnicity ethnicity;
//    Race race;
//    Gender gender;
//    Party party;
//    Age age;

//   QueryDataDisAgree({this.ethnicity, this.race, this.gender, this.party, this.age});
// }


// class QueryDataUndecided{
//    Ethnicity ethnicity;
//    Race race;
//    Gender gender;
//    Party party;
//    Age age;

//   QueryDataUndecided({this.ethnicity, this.race, this.gender, this.party, this.age});
// }

// class Ethnicity{
//    int hisp;
//    int notHisp;

//   Ethnicity({this.hisp, this.notHisp});
// }


// class Party{
//    int democrat;
//    int independent;
//    int republic;
//    int other;

//   Party(this.democrat, this.independent, this.republic, this.other);
 
// }


class Age{
   int groupA;
   int groupB;
   int groupC;
   int groupD;

  Age({this.groupA, this.groupB, this.groupC, this.groupD});

 
}


class Gender{
   int male;
   int female;

  Gender({this.male, this.female});
}

class Race{
   int american;
   int asian;
   int african;
   int hawaian;
   int white;

  Race({this.american, this.asian, this.african, this.hawaian, this.white});
}
