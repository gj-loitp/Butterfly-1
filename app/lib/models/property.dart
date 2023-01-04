import 'package:butterfly/models/colors.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'text.dart';

part 'property.g.dart';
part 'property.freezed.dart';

abstract class PathProperty implements Property {
  double get strokeWidth;
  double get strokeMultiplier;
}

@freezed
class Property with _$Property {
  const factory Property.label(
      {@Default(12)
          double size,
      @Default(kColorBlack)
          int color,
      @Default(3)
          int fontWeight,
      @Default(false)
          bool lineThrough,
      @Default(false)
          bool underline,
      @Default(false)
          bool overline,
      @Default(false)
          bool italic,
      @Default(0)
          double letterSpacing,
      @Default(kColorBlack)
          int decorationColor,
      @Default(TextDecorationStyle.solid)
          TextDecorationStyle decorationStyle,
      @Default(1)
          double decorationThickness,
      @Default(HorizontalAlignment.left)
          HorizontalAlignment horizontalAlignment,
      @Default(VerticalAlignment.top)
          VerticalAlignment verticalAlignment}) = LabelProperty;

  @Implements<PathProperty>()
  const factory Property.pen({
    @Default(5) double strokeWidth,
    @Default(10) double strokeMultiplier,
    @Default(kColorBlack) int color,
    @Default(false) bool fill,
  }) = PenProperty;

  const factory Property.shape({
    @Default(5) double strokeWidth,
    required PathShape shape,
    @Default(kColorBlack) int color,
  }) = ShapeProperty;

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
}

@freezed
class PathShape with _$PathShape {
  const PathShape._();
  const factory PathShape.circle({@Default(kColorTransparent) int fillColor}) =
      CircleShape;
  const factory PathShape.rectangle(
      {@Default(kColorTransparent) int fillColor,
      @Default(0) double topLeftCornerRadius,
      @Default(0) double topRightCornerRadius,
      @Default(0) double bottomLeftCornerRadius,
      @Default(0) double bottomRightCornerRadius}) = RectangleShape;
  const factory PathShape.line() = LineShape;

  factory PathShape.fromJson(Map<String, dynamic> json) =>
      _$PathShapeFromJson(json);
}
