import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xmas_challenge/ui/providers/content_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fileContent = "";
  String inputFilePath = "./assets/inputs/input.txt";
  String inputSmallFilePath = "./assets/inputs/input_small.txt";


  @override
  Widget build(BuildContext context) {
    var contentProvider = context.read<ContentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("XMAS FINDER"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  contentProvider.readContent(inputSmallFilePath);
                },
                child: Text("input.txt")
              ),
              ElevatedButton(
                onPressed: () {

                },
                child: Text("upload .txt")
              )
            ],
          ),
          Container(
            child: contentProvider.hasFile() ? Text("${contentProvider.matrix ?? ""}") : Text("SELECT A FILE"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                contentProvider.hasFile() ? contentProvider.fileToMatrix(contentProvider.content) : null;
              });
            },
            child: Text("search")
          )
        ],
      ),
    );
  }
}