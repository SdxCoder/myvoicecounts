

class QueryDataPerson{
  int agree;
  int disagree;
  int undecided;
  int total;

  QueryDataPerson({this.agree, this.disagree, this.undecided});

   void calculatePercent(int total){
    agree = ((agree / total) * 100).toInt();
    disagree = ((disagree / total) * 100).toInt();
    undecided = ((undecided / total) * 100).toInt();

   }
}