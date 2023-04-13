import 'package:flutter/material.dart';
import 'package:expoin/constants.dart';

class TabBarFilter extends StatelessWidget {
   TabBarFilter({Key? key, this.onCashIn, this.onCashOut, this.onChange, this.index}) : super(key: key);

  VoidCallback? onCashIn;
  VoidCallback? onCashOut;
  VoidCallback? onChange;
  int? index;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Table(
      border: TableBorder.all(color: primary, width: 2),
      children: [
        TableRow(
          children: [
            InkWell(
              onTap: onCashIn,
              child: Container(
                color: index == 0 ? primary : Colors.white,
                padding: EdgeInsets.all(10),
                child: Center(child: Text('Achat', style: TextStyle(color: index == 0 ?Colors.white : Colors.black, fontWeight: bold),)),
              ),
            ),
            InkWell(
              onTap: onCashOut,
              child: Container(
                color: index == 1 ? primary : Colors.white,
                padding: EdgeInsets.all(10),
                child: Center(child: Text('Vente', style: TextStyle(color: index == 1 ? Colors.white : Colors.black, fontWeight: bold),)),
              ),
            ),
            InkWell(
              onTap: onChange,
              child: Container(
                  color: index == 2 ? primary : Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text('Change', style: TextStyle(color: index == 2 ? Colors.white : Colors.black, fontWeight: bold)))
              ),
            ),
          ],
        ),
      ],
    );
  }
}
