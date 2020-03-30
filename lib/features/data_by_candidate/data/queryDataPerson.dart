

// class QueryDataPerson{
//   int agree;
//   int disagree;
//   int undecided;
//   int total;

//   QueryDataPerson({this.agree, this.disagree, this.undecided});

//    void calculatePercent(int total){
//     agree = ((agree / total) * 100).toInt();
//     disagree = ((disagree / total) * 100).toInt();
//     undecided = ((undecided / total) * 100).toInt();

//    }
// }

class QueryDataPerson {
  QueryDataAgree agree;
  QueryDataDisAgree disagree;
  QueryDataUndecided undecided;
  int total = 0;

  QueryDataPerson({this.agree, this.disagree, this.undecided, this.total});
}

class QueryDataAgree {
  double hisp;
  double notHisp;
  double american;
  double asian;
  double african;
  double hawaian;
  double white;
  double male;
  double female;
  double democrat;
  double independent;
  double republic;
  double other;
  double groupA;
  double groupB;
  double groupC;
  double groupD;
  double groupE;
  double stateA;
  double stateB;
  double stateC;
  double stateD;
  double stateE;
  List<StateData> states;

  //  Ethnicity ethnicity;
  //  Race race;
  //  Gender gender;
  //  Party party;
  //  Age age;

  QueryDataAgree(
      {this.hisp,
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
      this.groupE,
      this.stateA,
      this.stateB,
      this.stateC,
      this.stateD,
      this.stateE,
      this.states});

  void calculatePercent(int total) {
    print('Total : $total');
    groupA = ((groupA / total) * 100);
    groupB = ((groupB / total) * 100);
    groupC = ((groupC / total) * 100);
    groupD = ((groupD / total) * 100);
    groupE = ((groupE / total) * 100);

    List<double> totalAduList = [];
    int index = 0;
    for (var state in states) {
      if (index >= states.length) {
        break;
      }

      double val = (states[index].totalAdu / total) * 100;
      print(val);
      totalAduList.add(val);
      index++;
    }
    int indexList = 0;
    for (var state in states) {
      if (indexList >= states.length) {
        break;
      }

      states[indexList].totalAdu = totalAduList[indexList];
      indexList++;
    }

    print("Calculate -agree -${states.map((e) => e.totalAdu)}");
    print("Calculate -adu List -${totalAduList.map((e) => e)}");

    democrat = ((democrat / total) * 100);
    independent = ((independent / total) * 100);
    republic = ((republic / total) * 100);
    other = ((other / total) * 100);

    american = ((american / total) * 100);
    hawaian = ((hawaian / total) * 100);
    african = ((african / total) * 100);
    asian = ((asian / total) * 100);
    white = ((white / total) * 100);

    male = ((male / total) * 100);
    female = ((female / total) * 100);

    hisp = ((hisp / total) * 100);
    notHisp = ((notHisp / total) * 100);
  }
}

class QueryDataUndecided {
  double hisp;
  double notHisp;
  double american;
  double asian;
  double african;
  double hawaian;
  double white;
  double male;
  double female;
  double democrat;
  double independent;
  double republic;
  double other;
  double groupA;
  double groupB;
  double groupC;
  double groupD;
  double groupE;
  double stateA;
  double stateB;
  double stateC;
  double stateD;
  double stateE;
  List<StateData> states;
  //  Ethnicity ethnicity;
  //  Race race;
  //  Gender gender;
  //  Party party;
  //  Age age;

  QueryDataUndecided(
      {this.hisp,
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
      this.groupE,
      this.stateA,
      this.stateB,
      this.stateC,
      this.stateD,
      this.stateE,
      this.states});

  void calculatePercent(int total) {
    groupA = ((groupA / total) * 100);
    groupB = ((groupB / total) * 100);
    groupC = ((groupC / total) * 100);
    groupD = ((groupD / total) * 100);
    groupE = ((groupE / total) * 100);

    List<double> totalAduList = [];
    int index = 0;
    for (var state in states) {
      if (index >= states.length) {
        break;
      }

      double val = (states[index].totalAdu / total) * 100;
      print(val);
      totalAduList.add(val);
      index++;
    }

    int indexList = 0;
    for (var state in states) {
      if (indexList >= states.length) {
        break;
      }

      states[indexList].totalAdu = totalAduList[indexList];
      indexList++;
    }

    print("Calculate -undecided -${states.map((e) => e.totalAdu)}");
    print("Calculate -adu List -${totalAduList.map((e) => e)}");

    democrat = ((democrat / total) * 100);
    independent = ((independent / total) * 100);
    republic = ((republic / total) * 100);
    other = ((other / total) * 100);

    american = ((american / total) * 100);
    hawaian = ((hawaian / total) * 100);
    african = ((african / total) * 100);
    asian = ((asian / total) * 100);
    white = ((white / total) * 100);

    male = ((male / total) * 100);
    female = ((female / total) * 100);

    hisp = ((hisp / total) * 100);
    notHisp = ((notHisp / total) * 100);
  }
}

class QueryDataDisAgree {
  double hisp;
  double notHisp;
  double american;
  double asian;
  double african;
  double hawaian;
  double white;
  double male;
  double female;
  double democrat;
  double independent;
  double republic;
  double other;
  double groupA;
  double groupB;
  double groupC;
  double groupD;
  double groupE;
  double stateA;
  double stateB;
  double stateC;
  double stateD;
  double stateE;
  List<StateData> states;
  //  Ethnicity ethnicity;
  //  Race race;
  //  Gender gender;
  //  Party party;
  //  Age age;

  QueryDataDisAgree(
      {this.hisp,
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
      this.groupE,
      this.stateA,
      this.stateB,
      this.stateC,
      this.stateD,
      this.stateE,
      this.states});

  void calculatePercent(int total) {
    groupA = ((groupA / total) * 100);
    groupB = ((groupB / total) * 100);
    groupC = ((groupC / total) * 100);
    groupD = ((groupD / total) * 100);
    groupE = ((groupE / total) * 100);

    List<double> totalAduList = [];
    int index = 0;
    for (var state in states) {
      if (index >= states.length) {
        break;
      }

      double val = (states[index].totalAdu / total) * 100;
      print(val);
      totalAduList.add(val);
      index++;
    }

    int indexList = 0;
    for (var state in states) {
      if (indexList >= states.length) {
        break;
      }

      states[indexList].totalAdu = totalAduList[indexList];
      indexList++;
    }

    print("Calculate -disagree -${states.map((e) => e.totalAdu)}");
    print("Calculate -adu List -${totalAduList.map((e) => e)}");

    democrat = ((democrat / total) * 100);
    independent = ((independent / total) * 100);
    republic = ((republic / total) * 100);
    other = ((other / total) * 100);

    american = ((american / total) * 100);
    hawaian = ((hawaian / total) * 100);
    african = ((african / total) * 100);
    asian = ((asian / total) * 100);
    white = ((white / total) * 100);

    male = ((male / total) * 100);
    female = ((female / total) * 100);

    hisp = ((hisp / total) * 100);
    notHisp = ((notHisp / total) * 100);
  }
}

class Age {
  double groupA;
  double groupB;
  double groupC;
  double groupD;

  Age({this.groupA, this.groupB, this.groupC, this.groupD});
}

class Gender {
  double male;
  double female;

  Gender({this.male, this.female});
}

class Race {
  double american;
  double asian;
  double african;
  double hawaian;
  double white;

  Race({this.american, this.asian, this.african, this.hawaian, this.white});
}

class StateData {
  double totalAdu;
  String state;

  StateData({this.totalAdu, this.state});
}
