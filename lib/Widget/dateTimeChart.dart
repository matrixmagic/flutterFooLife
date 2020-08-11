import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DateTimeComboLinePointChart extends StatelessWidget {
  final List<charts.Series> series;
  final _myState = new charts.UserManagedState<DateTime>();
  DateTimeComboLinePointChart(this.series);

  void _infoSelectionModelUpdated(charts.SelectionModel<DateTime> model) {
    // If you want to allow the chart to continue to respond to select events
    // that update the selection, add an updatedListener that saves off the
    // selection model each time the selection model is updated, regardless of
    // if there are changes.
    //
    // This also allows you to listen to the selection model update events and
    // alter the selection.
    _myState.selectionModels[charts.SelectionModelType.info] =
    new charts.UserManagedSelectionModel(model: model);
    print(charts.UserManagedSelectionModel(model: model).selectedDataConfig);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height:200,
        child: new charts.TimeSeriesChart(
          series,
          // Configure the default renderer as a line renderer. This will be used
          // for any series that does not define a rendererIdKey.
          userManagedState: _myState,
          primaryMeasureAxis: new charts.NumericAxisSpec(
              tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 10)),
          secondaryMeasureAxis: new charts.NumericAxisSpec(
              tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 100)),

          // This is the default configuration, but is shown here for  illustration.
          defaultRenderer: new charts.LineRendererConfig(includePoints: true),

          selectionModels: [
            new charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: _infoSelectionModelUpdated)

          ],
          // Custom renderer configuration for the point series.
          customSeriesRenderers: [
            new charts.PointRendererConfig(
              // ID used to link series to this renderer.
                customRendererId: 'customPoint')
          ],
          // Optionally pass in a [DateTimeFactory] used by the chart. The factory
          // should create the same type of [DateTime] as the data provided. If none
          // specified, the default creates local date time.
          dateTimeFactory: const charts.LocalDateTimeFactory(),

        ),
      ),
    );
  }

}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}