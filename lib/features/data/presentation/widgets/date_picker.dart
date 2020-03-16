import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../view_models/rangePicker_view_model.dart';

class DateRangePicker extends StatelessWidget {
  final ValueChanged<DatePeriod> onNewRangeSelected;

  DateRangePicker({Key key, this.onNewRangeSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
        onModelReady: (DateRangePickerModel model) => model.initialize(),
        viewModel: DateRangePickerModel(),
        builder: (context, model, child) => Column(
          children: <Widget>[
            _buildWeekDatePicker(model: model),
          ],
        ));
  }

  Widget _buildWeekDatePicker({
    DateRangePickerModel model,
  }) {
    // add some colors to default settings
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: model.periodLastColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: model.periodStartColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: model.periodMiddleColor, shape: BoxShape.rectangle),
    );

    

    return RangePicker(
        selectedPeriod: model.selectedPeriod,
        onChanged: (period) {
          model.selectPeriod(period);
          onNewRangeSelected(period);
        },
        firstDate: model.firstDate,
        lastDate: model.lastDate,
        datePickerStyles: styles);
  }
}
