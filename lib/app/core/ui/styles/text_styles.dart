import 'package:desafio_flutter_searchandstay/app/core/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  TextStyle get textLight => const TextStyle(fontWeight: FontWeight.w300);
  TextStyle get textRegular => const TextStyle(fontWeight: FontWeight.normal);
  TextStyle get textMedium => const TextStyle(fontWeight: FontWeight.w500);
  TextStyle get textSemiBold => const TextStyle(fontWeight: FontWeight.w600);
  TextStyle get textBold => const TextStyle(fontWeight: FontWeight.w700);
  TextStyle get textExtraBold => const TextStyle(fontWeight: FontWeight.w800);

  TextStyle get textButtonLabel =>
      textBold.copyWith(color: ColorsApp.instance.labelblack1, fontSize: 20);

  TextStyle get texLabelH1 =>
      textBold.copyWith(color: ColorsApp.instance.cardwhite, fontSize: 32);
  TextStyle get texLabelH2 =>
      textRegular.copyWith(color: ColorsApp.instance.cardwhite, fontSize: 20);
  TextStyle get texLabelH3 =>
      textRegular.copyWith(color: ColorsApp.instance.cardwhite, fontSize: 18);
  TextStyle get texLabelH4 =>
      textRegular.copyWith(color: ColorsApp.instance.cardwhite, fontSize: 16);
  TextStyle get texLabelH5 =>
      textRegular.copyWith(color: ColorsApp.instance.cardwhite, fontSize: 12);

  TextStyle get labelPage => texLabelH2.copyWith(
      color: ColorsApp.instance.cardwhite,
      fontWeight: TextStyles.instance.textExtraBold.fontWeight);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
