import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SearchRifm extends StatefulWidget {
  const SearchRifm({super.key});

  @override
  State<SearchRifm> createState() => _SearchRifmState();
}

class _SearchRifmState extends State<SearchRifm> {
  String result = "";
  String findText = "";
  TextEditingController textEditingController = TextEditingController();
  void find() async {
    String word = Uri.encodeQueryComponent(findText);
    http.get(Uri.parse('https://bagmanov.com/rifme.php?w=$word')).then((response) {
      setState(() {
        result = response.body;
      });
    }).catchError((error){
      print("Error: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите слово, а я найду ей рифму :) ',
                ),
                onChanged: (res){
                  setState(() {
                    findText = res;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: double.infinity, // <-- Your width
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      find();
                    },
                    child: const Text('Поиск'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(result, style : TextStyle(
                color: Colors.black,
              )),
            ),
          ],
        ),
      ),
    );
  }
}