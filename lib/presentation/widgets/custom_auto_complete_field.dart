import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:expoin/utils/utils.dart';

class CustomAutoCompleteField extends StatelessWidget {
   CustomAutoCompleteField({Key? key}) : super(key: key);

  List<String> suggestions = ListHelper.cryptosCategories;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 40,
        child: RawAutocomplete(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }else{
              List<String> matches = <String>[];
              matches.addAll(suggestions);

              matches.retainWhere((s){
                return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
              return matches;
            }
          },

          onSelected: (String selection) {
            print('You just selected $selection');
          },

          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: "Saisissez le nom d'un compte",
                hintStyle: TextStyle(fontStyle: FontStyle.normal, fontSize: 12),
                suffixIcon: Icon(Icons.search, size: 20,),
                contentPadding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (String value) {
                print('ok');
              },
            );
          },

          optionsViewBuilder: (BuildContext context, void Function(String) onSelected,
              Iterable<String> options) {
            return Material(
                child:SizedBox(
                    height: 200,
                    child:SingleChildScrollView(
                        child: Column(
                          children: options.map((opt){
                            return InkWell(
                                onTap: (){
                                  onSelected(opt);
                                },
                                child: Card(
                                  elevation: 1,
                                  margin: EdgeInsets.only(bottom: 1, right: 50),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 15, backgroundImage: AssetImage(cryptoImageSelector(opt)),),
                                    title: Text(opt, style: TextStyle(fontSize: 13),),
                                    // Card(
                                    //     child: Container(
                                    //       width: double.infinity,
                                    //       padding: EdgeInsets.all(10),
                                    //       child:Text(opt),
                                    //     )
                                    // ),
                                  ),
                                )
                            );
                          }).toList(),
                        )
                    )
                )
            );
          },
        ),
        // TypeAheadField(
        //   textFieldConfiguration: TextFieldConfiguration(
        //       autofocus: true,
        //       style: DefaultTextStyle.of(context).style.copyWith(
        //           fontStyle: FontStyle.italic
        //       ),
        //       decoration: InputDecoration(
        //         hintText: "Saisissez le nom d'un compte",
        //         hintStyle: TextStyle(fontStyle: FontStyle.normal),
        //         suffixIcon: Icon(Icons.search, size: 20,),
        //         contentPadding: EdgeInsets.only(top: 10, left: 15),
        //         focusedBorder: InputBorder.none,
        //         enabledBorder: InputBorder.none,
        //         errorBorder: InputBorder.none,
        //         border: InputBorder.none,
        //       )
        //   ),
        //   suggestionsCallback: (pattern) {
        //    // print('######################################################### $pattern');
        //     return ListHelper.cryptosCategories;
        //   },
        //   itemBuilder: (context, suggestion) {
        //     return ListTile(
        //       leading: Icon(Icons.shopping_cart),
        //       title: Text(suggestion),
        //     );
        //   },
        //   onSuggestionSelected: (suggestion) {
        //     print(suggestion);
        //   },
        // ),
      ),
    );

    //   Autocomplete(
    //   optionsBuilder: (TextEditingValue textEditingValue) {
    //     if (textEditingValue.text == '') {
    //       return const Iterable<String>.empty();
    //     }else{
    //       List<String> matches = <String>[];
    //       matches.addAll(suggestions);
    //
    //       matches.retainWhere((s){
    //         return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
    //       });
    //       return matches;
    //     }
    //   },
    //   onSelected: (String selection) {
    //     print('You just selected $selection');
    //   },
    // );
  }
}
