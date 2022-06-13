import 'package:flutter/material.dart';
import 'package:covid/navigationDrawer/navigationDrawer.dart';
import 'package:covid/helpers/style.dart';
import 'package:covid/widgets/custom_text.dart';
import './quiz.dart';
import './result.dart';

class symptomPage extends StatefulWidget {
   static const String routeName = '/symptomPage';
   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _symptomPageState();
  }
}

class _symptomPageState extends State<symptomPage> {
 
  final _questions = const [
    {
      'questionText':
          'Are you up to date with your COVID-19 vaccination?\n\n\n',
      'answers': [
        {'text': 'Yes', 'score': 0},
        {'text': 'No', 'score': 10},
      ],
    },
    {
      'questionText': 'Have you returned from travel outside of Cyprus?',
      'answers': [
        {'text': 'Yes', 'score': 10},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionText':
          'Have you been in close contact with anyone diagnosed with COVID-19 in the last 14 days?\n\nYou have been in close contact if you have been less than 6 feet away from an infected person for a cumulative total of 15 minutes or more over a 24-hour period.',
      'answers': [
        {'text': 'Yes', 'score': 20},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionText':
          'Have you experienced any of these COVID-19 like symptoms?\n\n\n    •Fever\n    •Cough\n    •Headache\n    •Loss of sense of smell\n    •Fatigue\n    •Runny nose/nasal congestion\n    •Chills\n    •Sore throat or painful swallowing\n    •Muscle aches\n    •Loss of appetite',
      'answers': [
        {'text': 'Yes', 'score': 20},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionText': 'Have you contracted COVID-19 before in the past?',
      'answers': [
        {'text': 'Yes', 'score': 5},
        {'text': 'No', 'score': 0},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // car aBool = true;
    // aBool = false;

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
        appBar: AppBar(
         title: CustomText(text: "Symptoms Survey ", color: white, size: 20),
          centerTitle: true,
          elevation: 0.5,
       ),
        drawer: navigationDrawer(),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      );
    
  }
}
 

