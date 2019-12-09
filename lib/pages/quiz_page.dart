import 'package:flutter/material.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/answer_overlay.dart';
import './score_page.dart';

//Stateful widget can change state over time. Useful for animation bla bla bla. BUT the class STATEFULWIDGET itself isnt changeable.
//WE CONNECT "STATE" with it which changes and helps us rebuild visuals and stuff.
class QuizPage extends StatefulWidget{
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("State in react is changeable", true),
    new Question("Pizza is the best", true),
    new Question("London is the Capital city of England", true),
    new Question("Pakistan is a Muslim Country", true),
    new Question("The capital city of Turkey is Izmir ", false),
    new Question("Dart is a programming language and used to build web and mobile apps ", true),
    new Question("React native is a cross platform used for both Android and IOS ", true),
    new Question("React is a java framework for building a web app ", false),
    new Question("Junk food is good for health", false),
    new Question("Flutter is awesome!", true),
    new Question("Flutter contains widgets and react native contains components ", true), 
     new Question("Istanbul is the perfect place to enjoy the rich diversity of America-", false),
    new Question("Everything in react is a Module ", false),
    new Question("Today is raining", false),
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayState = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState( () {     //Changing the state will cause rebuilding of the widget and hence overlay will pop-up
      overlayState = true; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(     //Stack layers children on top of each other unlike column which arranges widgets one below the other.
    fit: StackFit.expand,
      children: <Widget>[
        new Column( // This is the main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),   //Answer Button
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))   //Answer False
          ],          
        ),
        overlayState == true ? new AnswerOverlay(
          isCorrect,
          () {
            if (quiz.length == questionNumber) {
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
              return;
            }
            currentQuestion = quiz.nextQuestion;
            this.setState(() {
              overlayState = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            }); 
          }  
        ) : new Container()
      ],
    );
  }
}
