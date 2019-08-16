import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:BMI/components/icon_content.dart';
import 'package:BMI/components/reusable_card.dart';
import 'package:BMI/constants.dart';
import 'package:BMI/components/Bottom_Button.dart';
import 'package:BMI/components/round_icon_button.dart';
import 'package:BMI/calculator_brain.dart';
import 'result_score.dart';

enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
    Gender selectedGender;
    int height = 100;
    int weight = 60;
    int age = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('BMI Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender=Gender.male;
                      });                      
                    },
                    colour: selectedGender==Gender.male ? kActiveCardColour:kInactiveCardColour,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                      ),
                    ),
                ),
                Expanded(child:
                  ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender=Gender.female;
                      });
                    },
                   colour: selectedGender == Gender.female ? kActiveCardColour : kInactiveCardColour,
                   cardChild: IconContent(
                     icon: FontAwesomeIcons.venus,
                     label: 'FEMALE',
                     ),
                   ),                  
                  ),                     
                ],
              ),
          ),
          Expanded(child:
            ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLableTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[

                      Text(
                        height.toString(),
                        style: kNumTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLableTextStyle,
                      )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xFF8D8E98),
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                  ),
                  child: Slider(
                    value: height.toDouble(),
                    max: 220.0,
                    onChanged: (double newValue) {                    
                      setState(() {
                        height=newValue.round();
                      });
                    },
                  ),
                 ),   
                ],
              ),
            ),
          ),
          
          Expanded(child:
           Row(             
            children: <Widget>[              
              Expanded(child:              
               ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[    
                    Text(
                      'WEIGHT',
                     style: kLableTextStyle,                 
                    ),
                    Text(
                      weight.toString(),
                      style: kNumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: (){
                            setState(() {
                            weight--;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed:(){
                            setState(() {
                            weight++;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),  
                      ],                                
                    ),
                  ],
                ),
               ),
              ),
              
              Expanded(child: 
                ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'AGE',
                        style: kLableTextStyle,
                      ),
                      Text(
                        age.toString(),
                        style: kNumTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: (){
                            setState(() {
                            age--;
                          });
                          },
                        ),
                        SizedBox(
                          width: 10.0,
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
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: (){
              CalculatorBrain calc = CalculatorBrain(height: height,weight: weight);
               Navigator.push(
                context, 
                MaterialPageRoute(
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
      ),          
    );
  }
}



