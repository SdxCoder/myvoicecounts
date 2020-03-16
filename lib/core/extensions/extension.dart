import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime{
  String getDate(){
  
  var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(this);
    String month = this.month.toString();
    String year = this.year.toString();
    String day = this.day.toString();
    
    return formatted;
  } 
}


extension StringExtension on String{
  String getAdu(){
  
    if(this == 'agree'){
      return 'agree';
    }

    if(this == 'disagree'){
      return 'disagree';
    }

    if(this == 'undecided'){
      return 'undecided';
    }
  
  } 
}