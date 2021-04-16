import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dolar', 'Pounds'];
  var _currentValue;
  var displayText = "0";
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentValue = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(title: Text("Calculator Bar")),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: [
                getImageAsset(),
                Padding(
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (String input) {
                      if (input.isEmpty) {
                        return 'Please enter a principal amount';
                      }
                    },
                    style: textStyle,
                    controller: principalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color:Colors.yellowAccent,
                          fontSize: 20.0
                        ),
                        hintText: "Enter Principal e.g 12000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                ),
                Padding(
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (String input) {
                      if (input.isEmpty) {
                        return 'Please enter a rate of Interest';
                      }
                    },
                    style: textStyle,
                    controller: roiController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: "In %",
                        errorStyle: TextStyle(
                            color:Colors.yellowAccent,
                            fontSize: 20.0
                        ),
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            // ignore: missing_return
                            validator: (String input) {
                              if (input.isEmpty) {
                                return 'Please enter a term';
                              }
                            },
                            style: textStyle,
                            controller: termController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Term',
                                errorStyle: TextStyle(
                                    color:Colors.yellowAccent,
                                    fontSize: 12.0
                                ),
                                hintText: "In years",
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ),
                        ),
                        Container(
                          width: 25.0,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          style: textStyle,
                          items: _currencies.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          value: _currentValue,
                          onChanged: (String newValueSelected) {
                            setState(() {
                              _currentValue = newValueSelected;
                            });
                          },
                        ))
                      ],
                    )),
                Padding(
                  child: Row(
                    children: [
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayText = _calculateTotalReturn();
                            }
                          });
                        },
                      )),
                      Container(
                        width: 15.0,
                      ),
                      Expanded(
                          child: RaisedButton(
                        color: Colors.orange,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            this.termController.text = '';
                            this.roiController.text = '';
                            this.principalController.text = '';
                            this.displayText = '';
                          });
                        },
                      ))
                    ],
                  ),
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 100.0),
                  child: Text(
                    this.displayText,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/picture.png');
    Image image = Image(
      image: assetImage,
      width: 100.0,
      height: 100.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double total = principal + (principal * rate * term) / 100;
    return total.toString() + " " + this._currentValue;
  }
}
