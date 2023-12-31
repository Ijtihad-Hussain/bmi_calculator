import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'resusable_card.dart';
import 'icon_content.dart';
import 'constants.dart';
import 'result_page.dart';
import 'roundButton.dart';
import 'bottom_button.dart';
import 'calculator_brain.dart';

enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Color maleCardColour = kInactiveCardColour;
  Color femaleCardColour = kInactiveCardColour;
  int height = 180;
  int weight=60;
  int age=20;

  //1 for male, 2 for female
  void updateColour(Gender selectedGender) {
    //male card pressed
    if (selectedGender == Gender.male) {
      if (maleCardColour == kInactiveCardColour) {
        maleCardColour = kActiveCardColour;
        femaleCardColour = kInactiveCardColour;
      } else {
        maleCardColour = kInactiveCardColour;
      }
    }
    if (selectedGender == Gender.female) {
      if (femaleCardColour == kInactiveCardColour) {
        femaleCardColour = kActiveCardColour;
        maleCardColour = kInactiveCardColour;
      } else {
        femaleCardColour = kInactiveCardColour;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
        backgroundColor: Color(0xFF181818),
      ),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Expanded(child: Row(
            children: [
              Expanded(child: ReusableCard(
                onPress: (){
                  setState(() {
                    updateColour(Gender.male);
                  });
                },
                colour: maleCardColour,
                cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: 'MALE'
                ),
              ),
              ),
              Expanded(child: ReusableCard(
                onPress: (){
                  setState(() {
                    updateColour(Gender.female);
                  });
                },
                colour: femaleCardColour,
                cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE'
                ),
              ),
              ),
            ],
          )),
          Expanded(child: ReusableCard(
            colour: kActiveCardColour,
            cardChild: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HEIGHT',
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(
                     height.toString(),
                     style: kNumberTextStyle,
                    ),
                    Text(
                      'cm',
                      style: kLabelTextStyle,
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTickMarkColor: Color(0xFF8D8E98),
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    onChanged: (double newValue){
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  ),
                )
              ],
            ),
            ),
          )),
          Expanded(child: Row(
            children: <Widget> [
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget> [
                            Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                            Text(
                             'kg',
                              style: kLabelTextStyle,
                          ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(width: 10.0
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'AGE',
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children:<Widget> [
                          Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                          Text(
                            'yrs',
                            style: kLabelTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: (){
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(width: 10.0
                          ),
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: (){
                              setState(() {
                                age++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  ),
                ),
              ),
            ],
          )),
          BottomButton(
          buttonTitle: 'CALCULATE',
          onTap: (){

            CalculatorBrain calc = CalculatorBrain(height:height, weight:weight);

            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ResultPage(
                  bmiResult: calc.calculateBMI(),
                  resultText: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                ),
            ),
            );
          },
          ),
        ],
      )
      );
  }
}
