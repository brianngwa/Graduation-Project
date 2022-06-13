import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    String resultTitle;
    if (resultScore <= 15) {
      resultTitle = '\nYou are Safe';
      resultText =
          '\n\nAccording to your self-assessment answers we have deemed you to be safe of contracting the covid-19 virus. \n\n\n\n\n\n\n\n\n\n\n\n';
    } else if (resultScore >= 20) {
      resultTitle = '\nSelf-Isolate and Take Covid Test';
      resultText =
          '\n\n\nAccording to your self-assessment answers you should isolate at home, wearing a well-fitting mask around others, until you are able to receive results of a COVID-19 test.\n\nDon\'t forget to upload your covid result if you are tested as positive! \n\n\n\n\n\n';
    }

    return resultTitle + "" + resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Row( 
            
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "images/result.png",
                            width: 160,
                          ),
                        ],
                      ),
          
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
          ),
          FlatButton(
            child: Text('Restart Self-Assessment'),
            textColor: Colors.blue,
            onPressed: resetHandler,
          )
        ],
      ),
    );
  }
}
