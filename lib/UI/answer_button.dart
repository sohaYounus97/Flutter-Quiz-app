import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{
  final bool _answer;
  final VoidCallback _onTap;   

  AnswerButton(this._answer, this._onTap);

  @override
  Widget build(BuildContext context) {
    return new Expanded( // True Button
      child: new Material(
        color: _answer==true?Colors.lightBlueAccent : Colors.orangeAccent,
          child: new InkWell(
            onTap: () => _onTap(),
              child: new Center(
                child: new Container(  
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.yellowAccent, width: 3.0)
                  ),                      
                  padding: new EdgeInsets.all(25.0),   
                  child: new Text(_answer==true?"True" : "False", 
                  style: new TextStyle(fontSize: 40.0, color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                )
              ),
            )
          )
        );
  }
}
