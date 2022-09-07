import 'package:flutter/material.dart';

class Crypto extends StatefulWidget {
  const Crypto({Key? key}) : super(key: key);

  @override
  State<Crypto> createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: ListView(
        children: [
          Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: [
                  Step(title: Text("Etape1"),
                      content: Column(
                        children: [
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                        ],
                      ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(title: Text("Etape2"),
                      content: Column(
                        children: [
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                          TextFormField(),
                        ],
                      )
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 1 ?
    setState(() => _currentStep += 1): null;
  }

  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
}
