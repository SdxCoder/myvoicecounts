

import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:myvoicecounts/core/core.dart';

class DateRangePickerModel extends BaseModel{
  DatePeriod selectedPeriod;

  Color periodStartColor;
  Color periodLastColor;
  Color periodMiddleColor;

  DateTime firstDate;
  DateTime lastDate;

  void initialize(){
    selectedPeriod = DatePeriod(DateTime.now().subtract(Duration(days: 14)), DateTime.now().subtract(Duration(days: 14)));
    firstDate = DateTime.now().subtract(Duration(days: 600));
    lastDate = DateTime.now().add(Duration(days: 30));
    periodStartColor = themeData.primaryColor;
    periodLastColor = themeData.primaryColor;
    periodMiddleColor = themeData.accentColor;
  }

  void selectPeriod(DatePeriod period){
    selectedPeriod = period;
    periodStartColor = themeData.primaryColor;
    periodLastColor = themeData.primaryColor;
    periodMiddleColor = themeData.accentColor;
    notifyListeners();
  }

}