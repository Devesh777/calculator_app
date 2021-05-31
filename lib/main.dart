import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false ,
  home:SiForm(),
  theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.greenAccent[700],
    accentColor: Colors.greenAccent[400]
  ),
));

class SiForm extends StatefulWidget {
  @override
  _SiFormState createState() => _SiFormState();
}

class _SiFormState extends State<SiForm> {
  String _value='Rupees';

  var _formkey=GlobalKey<FormState>();

  var display='';

  void _onDropDown(String value){
    setState(() {
      this._value=value;
    });

  }


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.title;



    TextEditingController principal=TextEditingController();
    TextEditingController time=TextEditingController();
    TextEditingController interest=TextEditingController();

    String _calculate(){
      double principall=double.parse(principal.text);
      double years=double.parse(time.text);
      double roi=double.parse(interest.text);

      double total=principall+(principall*years*roi)*100;

      String result='After $years your investment will be worth ${this._value} $total';
      return result;
    }
    void _reset(){
      principal.text='';
      interest.text='';
      time.text='';
      _value='Rupees';
      display='';


    }
    return Scaffold(

      appBar: AppBar(
        title: Text('Simple Interest'),

      ),
      body:Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(

            children: <Widget>[
              Center(child:Container(
                child: Image.asset('images/money.jpg',width: 250.0,height:150.0),
                //margin: EdgeInsets.fromLTRB(50, 15, 100, 0.0),
                margin:EdgeInsets.only(top:30)

              ),),
              Container(width:1.0),
              Container(
                margin:EdgeInsets.fromLTRB(12, 50, 10.0, 0.0),
                child:TextFormField(
                  controller: principal,
                  style: textStyle,
                  keyboardType:TextInputType.number,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter principal value';
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.amber[600],
                      fontSize: 15.0
                    ),
                    hintStyle: textStyle,
                    hintText: 'Enter the Principal Value',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
              )
              ),
              Container(
                margin:EdgeInsets.fromLTRB(12, 25, 10.0, 0.0),
                child:TextFormField(
                  controller: interest,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter the rate of interest';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Rate of Interest',
                    hintStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.amber[600],
                      fontSize: 15.0
                    ),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )



                  ),
                )
              ),
              Container(
                  margin:EdgeInsets.fromLTRB(12, 25, 10.0, 0.0),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child:Container(
                        child: TextFormField(
                          controller: time,
                          keyboardType: TextInputType.number,
                          validator:(String value){
                            if(value.isEmpty){
                              return 'Please enter the time period';
                            }
                          },
                          style: textStyle,
                          decoration: InputDecoration(
                            hintText: 'Time(in years)',
                            hintStyle: textStyle,
                            errorStyle: TextStyle(
                              color:Colors.amber[600],
                              fontSize: 15.0
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                            )
                          ),
                        ),

                      ),),
                      Container(width:2.0),
                      Expanded(child:Container(
                        child:DropdownButton(

                            items:[
                              DropdownMenuItem(
                                child:Text('Rupees'),
                                value:'Rupees'
                              ),
                              DropdownMenuItem(
                                child:Text('Dollars'),
                                value:'Dollars',
                              ),
                              DropdownMenuItem(
                                child:Text('Pounds'),
                                value:'Pounds',
                              )
                            ],
                          onChanged: (String fvalue){
                            _onDropDown(fvalue);
                          },
                          value: _value,
                          style: textStyle
                        )
                      ),),

                    ],
                  ),
                )
              ),
              Container(
                  margin:EdgeInsets.fromLTRB(12, 25, 10.0, 0.0),
                  child:Row(
                    children: <Widget>[
                      Expanded(
                          child:RaisedButton(
                            color:Theme.of(context).primaryColor,
                            child:Text('Calculate',textScaleFactor: 1.5,),
                            onPressed: (){
                              setState(() {
                                if(_formkey.currentState.validate()){
                                  this.display=_calculate();
                                }

                              });
                            },
                          )
                      ),
                      Expanded(
                          child:RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child:Text('Reset',textScaleFactor: 1.5,),
                            onPressed: (){
                              setState(() {
                                _reset();
                              });
                            },

                          )
                      ),
                    ],
                  )
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child:Text('${this.display}',style:textStyle)
              )
            ],
          ),
        ),
      )

    );
  }
}
