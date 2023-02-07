import 'dart:ui';
import 'dart:ui' as dart_ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:syncfusion_flutter_charts/syncFlutterCore/src/utils/helper.dart';


import '../chart_series/series_renderer_properties.dart';
import '../chart_series/waterfall_series.dart';
import '../chart_series/xy_data_series.dart';
import '../common/data_label_renderer.dart';
import '../utils/helper.dart';



/// Customizes the markers.
///
/// Markers are used to provide information about the exact point location. You can add a shape to adorn each data point.
/// Markers can be enabled by using the [isVisible] property of [MarkerSettings].
///
/// Provides the options of [color], border width, border color and [shape] of the marker to customize the appearance.
///
@immutable
class MarkerSettings {
  /// Creating an argument constructor of MarkerSettings class.
  const MarkerSettings(
      {bool? isVisible,
      double? height = 8,
      double? width = 8,
      this.color,
      DataMarkerType? shape,
      double? borderWidth,
      this.borderColor,
      this.image})
      : isVisible = isVisible ?? false,
        height = height ?? 8,
        width = width ?? 8,
        shape = shape ?? DataMarkerType.circle,
        borderWidth = borderWidth ?? 2;

  ///Toggles the visibility of the marker.
  ///
  ///Defaults to `false`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(isVisible: true),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Height of the marker shape.
  ///
  ///Defaults to `4`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, height: 10),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double height;

  ///Width of the marker shape.
  ///
  ///Defaults to `4`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, width: 10),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the marker shape.
  ///
  ///Defaults to `null`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, color: Colors.red),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color? color;

  ///Shape of the marker.
  ///
  ///Defaults to `DataMarkerType.circle`.
  ///
  ///Also refer [DataMarkerType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, shape: DataMarkerType.diamond),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final DataMarkerType shape;

  ///Border color of the marker.
  ///
  ///Defaults to `null`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                          isVisible: true,
  ///                          borderColor: Colors.red, borderWidth: 3),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color? borderColor;

  ///Border width of the marker.
  ///
  ///Defaults to `2`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true,
  ///                         borderWidth: 2, borderColor: Colors.pink),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Image to be used as marker.
  ///
  ///Defaults to `null`
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, image: const AssetImage('images/bike.png'),
  ///                         shape: DataMarkerType.image),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ImageProvider? image;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MarkerSettings &&
        other.isVisible == isVisible &&
        other.height == height &&
        other.width == width &&
        other.color == color &&
        other.shape == shape &&
        other.borderWidth == borderWidth &&
        other.borderColor == borderColor &&
        other.image == image;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      isVisible,
      height,
      width,
      color,
      shape,
      borderWidth,
      borderColor,
      image
    ];
    return hashList(values);
  }
}

/// Marker settings renderer class for mutable fields and methods
class MarkerSettingsRenderer {
  /// Creates an argument constructor for MarkerSettings renderer class
  MarkerSettingsRenderer(this.markerSettings) {
    color = markerSettings.color;

    borderColor = markerSettings.borderColor;

    borderWidth = markerSettings.borderWidth;
  }

  /// Holds the marker settings value
  final MarkerSettings markerSettings;

  /// Holds the color value
  // ignore: prefer_final_fields
  Color? color;

  /// Holds the value of border color
  Color? borderColor;

  /// Holds the value of border width
  late double borderWidth;

  /// Holds the value of image
  dart_ui.Image? image;

  /// Specifies the image drawn in the marker or not.
  bool isImageDrawn = false;

  /// To paint the marker here
  void renderMarker(
      SeriesRendererDetails seriesRendererDetails,
      CartesianChartPoint<dynamic> point,
      Animation<double>? animationController,
      Canvas canvas,
      int markerIndex,
      [int? outlierIndex]) {
    final bool isDataPointVisible = isLabelWithinRange(
        seriesRendererDetails, seriesRendererDetails.dataPoints[markerIndex]);
    Paint strokePaint, fillPaint;
    final XyDataSeries<dynamic, dynamic> series =
        seriesRendererDetails.series as XyDataSeries<dynamic, dynamic>;
    final Size size =
        Size(series.markerSettings.width, series.markerSettings.height);
    final DataMarkerType markerType = series.markerSettings.shape;
    CartesianChartPoint<dynamic> point;
    final bool hasPointColor = series.pointColorMapper != null;
    final bool isBoxSeries =
        seriesRendererDetails.seriesType.contains('boxandwhisker');
    final double opacity = (animationController != null &&
            (seriesRendererDetails
                        .stateProperties.renderingDetails.initialRender! ==
                    true ||
                seriesRendererDetails.needAnimateSeriesElements == true))
        ? animationController.value
        : 1;
    point = seriesRendererDetails.dataPoints[markerIndex];
    Color? seriesColor = seriesRendererDetails.seriesColor;
    if (seriesRendererDetails.seriesType == 'waterfall') {
      seriesColor = getWaterfallSeriesColor(
          seriesRendererDetails.series as WaterfallSeries<dynamic, dynamic>,
          point,
          seriesColor);
    }
    borderColor = series.markerSettings.borderColor ?? seriesColor;
    color = series.markerSettings.color;
    borderWidth = series.markerSettings.borderWidth;
    !isBoxSeries
        ? seriesRendererDetails.markerShapes.add(isDataPointVisible
            ? getMarkerShapesPath(
                markerType,
                Offset(point.markerPoint!.x, point.markerPoint!.y),
                size,
                seriesRendererDetails,
                markerIndex,
                null,
                animationController)
            : null)
        : seriesRendererDetails.markerShapes.add(isDataPointVisible
            ? getMarkerShapesPath(
                markerType,
                Offset(point.outliersPoint[outlierIndex!].x,
                    point.outliersPoint[outlierIndex].y),
                size,
                seriesRendererDetails,
                markerIndex,
                null,
                animationController)
            : null);
    if (seriesRendererDetails.seriesType.contains('range') == true ||
        seriesRendererDetails.seriesType == 'hilo') {
      seriesRendererDetails.markerShapes2.add(isDataPointVisible
          ? getMarkerShapesPath(
              markerType,
              Offset(point.markerPoint2!.x, point.markerPoint2!.y),
              size,
              seriesRendererDetails,
              markerIndex,
              null,
              animationController)
          : null);
    }
    strokePaint = Paint()
      ..color = point.isEmpty == true
          ? (series.emptyPointSettings.borderWidth == 0
              ? Colors.transparent
              : series.emptyPointSettings.borderColor.withOpacity(opacity))
          : (series.markerSettings.borderWidth == 0
              ? Colors.transparent
              : ((hasPointColor && point.pointColorMapper != null)
                  ? point.pointColorMapper!.withOpacity(opacity)
                  : borderColor!.withOpacity(opacity)))
      ..style = PaintingStyle.stroke
      ..strokeWidth = point.isEmpty == true
          ? series.emptyPointSettings.borderWidth
          : borderWidth;

    if (series.gradient != null && series.markerSettings.borderColor == null) {
      strokePaint = getLinearGradientPaint(
          series.gradient!,
          getMarkerShapesPath(
                  markerType,
                  Offset(
                      isBoxSeries
                          ? point.outliersPoint[outlierIndex!].x
                          : point.markerPoint!.x,
                      isBoxSeries
                          ? point.outliersPoint[outlierIndex!].y
                          : point.markerPoint!.y),
                  size,
                  seriesRendererDetails,
                  null,
                  null,
                  animationController)
              .getBounds(),
          seriesRendererDetails.stateProperties.requireInvertedAxis);
      strokePaint.style = PaintingStyle.stroke;
      strokePaint.strokeWidth = point.isEmpty == true
          ? series.emptyPointSettings.borderWidth
          : series.markerSettings.borderWidth;
    }

    fillPaint = Paint()
      ..color = point.isEmpty == true
          ? series.emptyPointSettings.color
          : color != Colors.transparent
              ? (color ??
                      (seriesRendererDetails.stateProperties.renderingDetails
                                  .chartTheme.brightness ==
                              Brightness.light
                          ? Colors.white
                          : Colors.black))
                  .withOpacity(opacity)
              : color!
      ..style = PaintingStyle.fill;
    final bool isScatter = seriesRendererDetails.seriesType == 'scatter';
    final Rect axisClipRect =
        seriesRendererDetails.stateProperties.chartAxis.axisClipRect;

    // Render marker points
    if ((series.markerSettings.isVisible || isScatter || isBoxSeries) &&
        point.isVisible &&
        _withInRect(seriesRendererDetails, point.markerPoint, axisClipRect) &&
        (point.markerPoint != null ||
            // ignore: unnecessary_null_comparison
            point.outliersPoint[outlierIndex!] != null) &&
        point.isGap != true &&
        (!isScatter || series.markerSettings.shape == DataMarkerType.image) &&
        seriesRendererDetails
                .markerShapes[isBoxSeries ? outlierIndex! : markerIndex] !=
            null) {
      seriesRendererDetails.renderer.drawDataMarker(
          isBoxSeries ? outlierIndex! : markerIndex,
          canvas,
          fillPaint,
          strokePaint,
          isBoxSeries
              ? point.outliersPoint[outlierIndex!].x
              : point.markerPoint!.x,
          isBoxSeries
              ? point.outliersPoint[outlierIndex!].y
              : point.markerPoint!.y,
          seriesRendererDetails.renderer);
      if (series.markerSettings.shape == DataMarkerType.image) {
        drawImageMarker(
            seriesRendererDetails,
            canvas,
            isBoxSeries
                ? point.outliersPoint[outlierIndex!].x
                : point.markerPoint!.x,
            isBoxSeries
                ? point.outliersPoint[outlierIndex!].y
                : point.markerPoint!.y);
        if (seriesRendererDetails.seriesType.contains('range') == true ||
            seriesRendererDetails.seriesType == 'hilo') {
          drawImageMarker(seriesRendererDetails, canvas, point.markerPoint2!.x,
              point.markerPoint2!.y);
        }
      }
    }
  }

  /// To determine if the marker is within axis clip rect
  bool _withInRect(SeriesRendererDetails seriesRendererDetails,
      ChartLocation? markerPoint, Rect axisClipRect) {
    bool withInRect = false;

    withInRect = markerPoint != null &&
        markerPoint.x >= axisClipRect.left &&
        markerPoint.x <= axisClipRect.right &&
        markerPoint.y <= axisClipRect.bottom &&
        markerPoint.y >= axisClipRect.top;

    return withInRect;
  }

  /// Paint the image marker
  void drawImageMarker(SeriesRendererDetails seriesRendererDetails,
      Canvas canvas, double pointX, double pointY) {
    //  final MarkerSettingsRenderer markerSettingsRenderer = seriesRenderer.seriesRendererDetails.markerSettingsRenderer;
    if (seriesRendererDetails.markerSettingsRenderer!.image != null) {
      final double imageWidth =
          2 * seriesRendererDetails.series.markerSettings.width;
      final double imageHeight =
          2 * seriesRendererDetails.series.markerSettings.height;
      final Rect positionRect = Rect.fromLTWH(pointX - imageWidth / 2,
          pointY - imageHeight / 2, imageWidth, imageHeight);
      paintImage(
          canvas: canvas, rect: positionRect, image: image!, fit: BoxFit.fill);
    }
  }
}
