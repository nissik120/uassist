import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpecializationData{
  static final Map<String, IconData> specializationMap = {
    'art': FontAwesomeIcons.palette,
    'applied sciences': FontAwesomeIcons.vials,
    'agriculture': FontAwesomeIcons.tractor,
    'built environment': FontAwesomeIcons.laptopHouse,
    'business studies': FontAwesomeIcons.briefcase,
    'commerce': FontAwesomeIcons.moneyBill,
    'education': FontAwesomeIcons.chalkboardTeacher,
    'engineering': FontAwesomeIcons.hardHat,
    'humanities': FontAwesomeIcons.peopleArrows,
    'law': FontAwesomeIcons.balanceScale,
    'marine': FontAwesomeIcons.fish,
    'media studies': FontAwesomeIcons.tv,
    'medicine': FontAwesomeIcons.hospitalAlt,
    'science': FontAwesomeIcons.microscope,
    'social sciences': FontAwesomeIcons.users,
    'technical training': FontAwesomeIcons.cogs,
  };
}