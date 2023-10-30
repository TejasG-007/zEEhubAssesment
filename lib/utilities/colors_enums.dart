import 'package:flutter/material.dart';

enum CustomColors { yellow, red, violet ,green}

extension GetColors on CustomColors {
  get getShadeColors => switch (this) {
        CustomColors.red => Colors.red.withOpacity(.5),
        CustomColors.yellow => Colors.yellow.withOpacity(.5),
        CustomColors.green => Colors.green.withOpacity(.5),
        CustomColors.violet => Colors.purple.withOpacity(.5),
      };

  get getColor => switch (this) {
        CustomColors.red => Colors.red,
        CustomColors.yellow => Colors.yellow,
        CustomColors.green => Colors.green,
        CustomColors.violet => Colors.purple,
      };

  get getOffset=>switch(this){
    CustomColors.red => const Offset(20,109),
    CustomColors.yellow => const Offset(90,20),
    CustomColors.green => const Offset(200,100),
    CustomColors.violet => const Offset(20,109),
  };
}
