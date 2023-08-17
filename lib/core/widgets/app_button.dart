import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opticash/core/widgets/app_text.dart';
import 'package:opticash/core/widgets/inline_loader.dart';

enum ButtonType { elevated, outline, flat }

/// A custom button that toggles Elevated, Outline or Flat.
///
/// The [AppButton.elevated] builds a button with elevation and a
/// [backgroundColor].
///
/// The [AppButton.flat] builds a flat button with a transparent background.
///
/// The button can have an [icon] and [text]. When both are not `null`, the
/// icon is built to the left of the text with a padding in between that is
/// half of its vertical padding.
///
/// When [onTap] is `null`, the button will appear disabled by reducing the
/// foreground and background opacity.
///
/// Either [icon] or [text] must not be `null`.
class AppButton extends StatelessWidget {
  /// A button that appears raised with a shadow.
  ///
  /// Uses the [Theme.primaryColor] as the [backgroundColor] by default.
  const AppButton.elevated({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.iconSize,
    this.backgroundColor,
    this.dense = false,
    this.disabled = false,
    this.padding,
    this.betweenPadding,
    this.foregroundColor = const Color(0xFF000000),
    this.style,
    this.width,
    this.height,
    this.weight,
    this.fontSize,
    this.borderRadius,
    this.isIconAfterText = false,
    this.shadowColor = Colors.transparent,
    double? elevation,
    this.gradientColors = const [],
    this.isLoading = false,
  })  : buttonType = ButtonType.elevated,
        elevation = elevation ?? 1,
        assert(text != null || icon != null);

  /// An Outlined button that has a transparent background and no shadow.
  ///
  /// Should only be used when the context makes it clear it can be tapped.
  const AppButton.outlined({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.iconSize,
    this.dense = false,
    this.disabled = false,
    this.padding,
    this.betweenPadding,
    this.foregroundColor,
    this.style,
    this.width,
    this.height,
    this.weight,
    this.fontSize,
    this.isIconAfterText = false,
    this.shadowColor = Colors.transparent,
    this.borderRadius,
    this.isLoading = false,
    this.gradientColors = const [],
  })  : buttonType = ButtonType.outline,
        backgroundColor = null,
        elevation = 0,
        assert(text != null || icon != null);

  /// A flat button that has a transparent background and no shadow.
  ///
  /// Should only be used when the context makes it clear it can be tapped.
  const AppButton.flat({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.iconSize,
    this.dense = false,
    this.disabled = false,
    this.padding,
    this.betweenPadding,
    this.foregroundColor,
    this.backgroundColor,
    this.style,
    this.width,
    this.height,
    this.weight,
    this.fontSize,
    this.isIconAfterText = false,
    this.shadowColor = Colors.transparent,
    this.borderRadius,
    this.isLoading = false,
    this.gradientColors = const [],
  })  : buttonType = ButtonType.flat,
        elevation = 0,
        assert(text != null || icon != null);

  /// The text widget of the button.
  ///
  /// Can be `null` if the button has no text.
  final String? text;

  /// The icon widget of the button.
  ///
  /// Can be `null` if the button has no icon.
  final Widget? icon;

  /// If button icon should display after button text
  /// defaults to false
  final bool isIconAfterText;

  /// The size of the [icon].
  ///
  /// Defaults to the current icon theme's size.
  final double? iconSize;

  /// The size of the [text].
  ///
  /// Defaults to 15.
  final double? fontSize;

  /// This weight of the [text]
  ///
  /// Defaults to FontWeight.w600
  final FontWeight? weight;

  ///
  /// Shows progress indicator when set to true.
  final bool isLoading;

  /// The callback when the button is tapped.
  ///
  /// If `null`, the button has reduced transparency to appear disabled.
  final VoidCallback onTap;

  /// Specifies the type of button, either Raised, Outlined or Flat.
  ///
  /// Uses global button theme.
  final ButtonType buttonType;

  /// The color of the button.
  ///
  /// Uses the [AppTheme.foregroundColor] if `null`.
  final Color? backgroundColor;

  /// The color of the [icon] and [text] of the button.
  ///
  /// Defaults to [kContrastColor] if the [backgroundColor] is `null`,
  /// to the text foreground color if the [backgroundColor] is transparent or to
  /// white or black when [backgroundColor] is set.
  final Color? foregroundColor;

  /// Button text style.
  final TextStyle? style;

  /// Whether the button should have less padding.
  ///
  /// Has no effect if [padding] is not `null`.
  final bool dense;

  /// The padding for the button.
  ///
  /// Should usually be `null` to use the default padding that is controlled
  /// with [dense] if a smaller padding is required.
  final EdgeInsets? padding;

  /// The padding between the [icon] and [text].
  ///
  /// Only has an affect when both [icon] and [text] is not `null`.
  ///
  /// Defaults to half of the vertical padding.
  final double? betweenPadding;

  /// The [elevation] that changes when using a [AppButton.flat] or
  /// [AppButton.raised].
  final double elevation;

  /// Specifies [width] of button
  final double? width;

  /// Specifies [height] of button
  final double? height;

  /// Specifies [borderRadius] of button
  final double? borderRadius;

  /// Specifies [ShadowColor] of button
  final Color? shadowColor;

  final bool disabled;

  final List<Color> gradientColors;

  EdgeInsets get _padding => padding ?? EdgeInsets.symmetric(vertical: dense ? 8 : 6, horizontal: dense ? 16 : 5);

  /// Builds the row with the [Icon] and [Text] widget.
  Widget _buildContent() {
    Widget content = Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: Center(
              child: AppText(
                text ?? "",
                size: fontSize ?? 16,
                weight: weight ?? FontWeight.w600,
                align: TextAlign.center,
                color: foregroundColor ?? Colors.black,
              ),
            ),
          ),
        ),
        if (icon != null)
          Positioned.fill(
            left: !isIconAfterText ? 4 : null,
            right: isIconAfterText ? 16 : null,
            child: icon!,
          )
      ],
    );

    return isLoading ? InlineLoader() : content;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: Builder(
        builder: (context) => DefaultTextStyle(
          style: Theme.of(context).textTheme.labelLarge!.merge(style),
          overflow: TextOverflow.fade,
          softWrap: false,
          child: _buildButton(),
        ),
      ),
    );
    // return _buildButton();
  }

  Widget _buildButton() {
    switch (buttonType) {
      case ButtonType.flat:
        return TextButton(
          onPressed: isLoading ? () {} : () => {HapticFeedback.mediumImpact(), onTap()},
          style: TextButton.styleFrom(
            foregroundColor: Colors.transparent.withOpacity(0),
            shadowColor: Colors.transparent,
          ),
          child: _buildContent(),
        );

      case ButtonType.outline:
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(offset: Offset(1, 1.2), color: kShadowColor, blurRadius: 1),
              BoxShadow(offset: Offset(1, -1.2), color: kShadowColor, blurRadius: 1),
              BoxShadow(offset: Offset(1.1, 0), color: kShadowColor, blurRadius: 1),
              BoxShadow(offset: Offset(-1.1, 0), color: kShadowColor, blurRadius: 1)
            ],
          ),
          child: OutlinedButton(
            onPressed: isLoading ? () {} : () => {HapticFeedback.lightImpact(), onTap()},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFFE8E8E8)),
              shadowColor: kShadowColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              minimumSize: Size(width ?? double.infinity, height ?? 56),
            ),
            child: _buildContent(),
          ),
        );

      default:
        return ElevatedButton(
          onPressed: isLoading ? () {} : () => {HapticFeedback.lightImpact(), disabled ? () {} : onTap()},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.zero,
            minimumSize: Size(width ?? double.infinity, height ?? 56),
            elevation: elevation,
            foregroundColor: foregroundColor ?? Colors.white,
            backgroundColor: disabled
                ? Colors.grey
                : gradientColors.isEmpty
                    ? (backgroundColor ?? Colors.black)
                    : Colors.transparent,
            shadowColor: shadowColor,
          ),
          child: gradientColors.isEmpty
              ? _buildContent()
              : Ink(
                  height: height ?? 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(colors: gradientColors),
                  ),
                  child: _buildContent(),
                ),
        );
    }
  }

  Color get kShadowColor => Color(0x40b8b8b8);
}
