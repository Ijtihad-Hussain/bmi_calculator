 import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorBrain{
  CalculatorBrain ({this.height, this.weight});

  final int height;
  final int weight;
  String weightLowerLimit;
  String weightHigherLimit;
  String weightToLoss;
  String weightToGain;

  double _bmi;

  String calculateBMI(){
    _bmi = weight / pow(height/100, 2); //height from cm to meters
    weightLowerLimit = (18.5 * pow(height/100, 2)).toStringAsFixed(1);
    weightHigherLimit = (24.9 * pow(height/100, 2)).toStringAsFixed(1);
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if (_bmi>=25){
      weightToLoss = (weight - 24.9 * pow(height/100, 2)).toStringAsFixed(1);
      return 'Overweight';
    } else if (_bmi >= 18.5){
      return 'Normal';
    } else {
      weightToGain = (18.5 * pow(height/100, 2) - weight).toStringAsFixed(1);
      return 'Underweight';
    }
  }

  String getInterpretation(){
    if (_bmi>=25){
      return 'The normal weight for your height ($weightLowerLimit kg - $weightHigherLimit kg)\nYour weight is $weight kg \nYou should reduce at least $weightToLoss kg';
    } else if (_bmi > 18.5){
      return 'The normal weight for your height ($weightLowerLimit kg - $weightHigherLimit kg)\nYour weight is $weight kg';
    } else {
      return 'The normal weight for your height ($weightLowerLimit kg - $weightHigherLimit kg)\nYour weight is $weight kg \nYou should gain at least $weightToGain kg';
    }
  }
}