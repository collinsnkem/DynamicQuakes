import 'package:earthquake_app/utils/colors.dart';
import 'package:earthquake_app/widgets/basic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:emoji_feedback/emoji_feedback.dart';

class QuakeFeedback extends StatefulWidget {
  @override
  _QuakeFeedbackState createState() => _QuakeFeedbackState();
}

class _QuakeFeedbackState extends State<QuakeFeedback> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  var slideVal = 0.0;
  var feedbackText = "Not At All";

    feedbackSubmit(){
      if(_formKey.currentState.validate()){
        print(_controller.text);

      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Thank you for the feedback'),
          content: Text('Your message was received'),
          actions: [
            OutlineButton(
              child: Text('Close', style: TextStyle(color: pryColor)),
              onPressed: () => Navigator.pop(context),
              color: secColor,
              ),
          ]
        );
      });
      } else {
        return null;
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: new IconThemeData(color: pryColor),
      ),
      body: Container(
          child: ListView(
        children: [
          Column(
            children: [
              Divider(),
              Text(
                'What do you think about our app?',
                style: TextStyle(
                    fontWeight: bold, fontFamily: 'Jost', fontSize: 20),
              ),
              SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width / 1.15,
                height: 1,
                color: secDark,
              ),
              SizedBox(height: 10),
              EmojiFeedback(
                onChange: (value) {
                  if (value == 0) {
                    print("That's terrible");
                  }
                },
              ),
              SizedBox(height: 30),
              Text(
                'What would you like to share with us?',
                style: TextStyle(
                    fontWeight: bold, fontFamily: 'Jost', fontSize: 20),
              ),
              SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width / 1.15,
                height: 1,
                color: secDark,
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    validator: (val) =>
                        val.isEmpty ? 'Please share your thought first' : null,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Your thoughts',
                      fillColor: secLight,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secDark),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secDark),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'How likely would you recommennd DynamicQuake to your friends and colleagues?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: bold, fontFamily: 'Jost', fontSize: 19),
              ),
              SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width / 1.15,
                height: 1,
                color: secDark,
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    Slider(
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      activeColor: pryColor,
                      inactiveColor: secDark,
                      value: slideVal,
                      onChanged: (slide) {
                        setState(() {
                          slideVal = slide;
                          print(slide);
                          if (slide >= 0.0 && slide <= 1.0) {
                            feedbackText = 'Could Be Better';
                          } else if (slide >= 1.0 && slide <= 2.0) {
                            feedbackText = 'Improved, But please do better';
                          } else if (slide >= 2.0 && slide <= 3.0) {
                            feedbackText = 'Hmnn, Please do better';
                          } else if (slide >= 3.0 && slide <= 4.0) {
                            feedbackText = 'Less likely';
                          } else if (slide >= 4.0 && slide <= 5.0) {
                            feedbackText = 'Likely, not sure';
                          } else if (slide >= 5.0 && slide <= 6.0) {
                            feedbackText = 'Yeah, I will';
                          } else if (slide >= 6.0 && slide <= 7.0) {
                            feedbackText = 'Yes, will recommend';
                          } else if (slide >= 7.0 && slide <= 8.0) {
                            feedbackText = 'Sure! will do';
                          } else if (slide >= 8.0 && slide <= 9.0) {
                            feedbackText = 'More likely';
                          } else if (slide >= 9.0 && slide <= 10.0) {
                            feedbackText = 'Of course, Very likely';
                          }
                        });
                      },
                    ),
                    Text(
                      feedbackText,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Jost'),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          feedbackSubmit();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: pryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontFamily: 'Jost',
                                color: white,
                                fontSize: 16,
                                fontWeight: bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }

    
}
