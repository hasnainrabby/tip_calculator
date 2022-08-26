import 'package:flutter/material.dart';

import '../utill/hexcolor.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator ({Key? key}) : super(key: key);

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {

  int _tipPercentage = 0;
  int _personCounter = 0;
  double _billAmount = 0.0;
  Color _lightblue = HexColor("#e6e6ff");
  Color _skyblue = HexColor("#31B2EA");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Tip Calculator",style: TextStyle(color: _lightblue)),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Container(

        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),  //dynamic code for various type of device
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _lightblue
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("Total per person",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                    Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("\$${calculateTotalPerPerson(_billAmount,_personCounter,_tipPercentage)}",
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),

              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.indigo.shade100,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                children:  [
                  TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: _skyblue ),
                      decoration: const InputDecoration(
                        prefixText: "Enter Amount ",
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String value){
                        try{
                          _billAmount = double.parse(value);

                        } catch(exception){
                          _billAmount = 0.0;
                        }
                      }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",style: TextStyle(color: Colors.grey.shade700),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(_personCounter > 1){
                                  _personCounter--;
                                }else{
                                  //nothing to do
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _lightblue.withOpacity(0.1),
                              ),
                              child: const Center(
                                child: Text(
                                  "-",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter",style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _lightblue.withOpacity(0.1),
                              ),
                              child: const Center(
                                child: Text(
                                  "+",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tip",style: TextStyle(
                            color: Colors.grey.shade700
                        ),),
                        Text("\$${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                            color: Colors.grey.shade700
                        ))
                      ],
                    ),
                  ),
                  //Slider
                  Column(
                    children: [
                      Text("$_tipPercentage%",style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: _skyblue.withOpacity(1.0))),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _lightblue,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue){
                            setState(() {
                              _tipPercentage = newValue.round();
                            });

                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  calculateTotalPerPerson(double billAmount,int splitBy,int tipPercentage){
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount)/ splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
  calculateTotalTip(double billAmount,int splitBy,int tipPercentage){
    double totalTip = 0.0;
    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){
      //nothing to do
    }else{
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}