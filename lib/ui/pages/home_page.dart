import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xmas_challenge/ui/providers/content_provider.dart';
import 'package:xmas_challenge/ui/shared/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fileContent = "";
  String inputFilePath = "./assets/inputs/input.txt";
  String inputSmallFilePath = "./assets/inputs/input_small.txt";
  String inputMeidumFilePath = "./assets/inputs/input_medium.txt";

  @override
  Widget build(BuildContext context) {
    var contentProvider = context.read<ContentProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroudColor,
        title: Text("XMAS FINDER", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contentProvider.readContent(inputMeidumFilePath);
                      });
                    },
                    child: Text("input.txt")
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contentProvider.readContent(inputSmallFilePath);
                      });
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
              Container(
                color: AppColors.resultBackgroundColor,
                height: MediaQuery.sizeOf(context).height/2,
                width: MediaQuery.sizeOf(context).width/1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: contentProvider.hasFile() ?  GridView.builder(
                      shrinkWrap: true,
                      itemCount: contentProvider.matrix!.length * contentProvider.matrix![0].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: contentProvider.matrix![0].length,
                        childAspectRatio: 1
                      ), 
                      itemBuilder: (context, index) {
                                  
                        int columnsN = contentProvider.matrix![0].length; 
                        int line = index ~/ columnsN; 
                        int column = index % columnsN;
                          
                        return Center(child: Text("${contentProvider.matrix?[line][column]}", style: TextStyle(fontWeight: FontWeight.w500),));
                      }
                    ) : Text("OPA")
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: AppColors.backgroudColor,
        child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contentProvider.hasFile() ? contentProvider.xmasFinder() : null;
                    });
                  },
                  child: Text("only xmas")
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      
                    });
                  },
                  child: Text("Reset")
                )
              ],
            ),
      ),
    );
  }
}