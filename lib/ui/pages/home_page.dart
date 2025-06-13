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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    contentProvider.readContent(inputFilePath);
                  },
                  child: Text("input.txt")
                ),
                ElevatedButton(
                  onPressed: () {
                    contentProvider.readContent(inputSmallFilePath);
                  },
                  child: Text("input_small.txt")
                ),
                ElevatedButton(
                  onPressed: () {
        
                  },
                  child: Text("upload .txt")
                )
              ],
            ),
            SizedBox(height: 10,),
            //POSSIVEL SOLUCAO PARA O INPUT GRANDE
            /*Expanded(
              child: contentProvider.hasFile() ? Text("${contentProvider.content}") : Text("SELECT A FILE"),
            ),*/
            Expanded(
              child: contentProvider.hasFile() ?  GridView.builder(
                itemCount: contentProvider.matrix!.length * contentProvider.matrix![0].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: contentProvider.matrix![0].length
                ), 
                itemBuilder: (context, index) {

                  int columnsN = contentProvider.matrix![0].length; 
                  int line = index ~/ columnsN; 
                  int column = index % columnsN;
        
                  return Text("${contentProvider.matrix?[line][column]}",);
                }
              ) : Text("")
            ),
            /*Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentProvider.hasFile() ? contentProvider.fileToMatrix(contentProvider.content) : null;
                    });
                  },
                  child: Text("load")
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentProvider.hasFile() ? contentProvider.fileToMatrix(contentProvider.content) : null;
                    });
                  },
                  child: Text("only xmas")
                )
              ],
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentProvider.hasFile() ? contentProvider.fileToMatrix(contentProvider.content) : null;
                    });
                  },
                  child: Text("load")
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentProvider.hasFile() ? contentProvider.xmasFinder() : null;
                    });
                  },
                  child: Text("only xmas")
                )
              ],
            ),
      ),
    );
  }
}