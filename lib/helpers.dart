import 'package:flutter/material.dart';
import 'package:locaapp/lang/app_locale.dart';

getTranslated(BuildContext context ,String key){
  return AppLocale.of(context).getTranslated(key);
}