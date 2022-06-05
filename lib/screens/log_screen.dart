import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/log_response.dart';
import 'package:app/services/services.dart';
import 'package:app/theme/app_theme.dart';

import '../providers/searchProvider.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final searchProv = Provider.of<LogSearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Bitacora de Servicios'),
        backgroundColor: Apptheme.primarylight,
      ),
    
      body: Center(
          child: Column(
            children: [
    
              SearchBar(size: size),
              _Title(size: size),
              LogGrid(size: size),
              
            ],
          ),
        ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.print),
        onPressed: searchProv.printData,
      ),
        
      );
    }
  }

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    final searchProv = Provider.of<LogSearchProvider>(context);
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height*.02),
      height: size.height*.08,
      width: size.width*.9,
      child: TextField(
        onChanged: (value) {

          if(searchProv.query != value){
          searchProv.setQuery(value);
          print(value);

          }
        },
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search,color: Colors.grey,) ,
          prefixIconColor: Colors.grey,
          hintText: 'Buscar Servicios',
          
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey
            )
          )
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.grey[300],
      ), 
      height: size.height*.1,
      width: size.width*.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Servicios',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.height*.03
            ),
          ),
        ],
      ),
    );
  }
}

class LogGrid extends StatelessWidget {
  const LogGrid({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    final logProvider = Provider.of<LogService>(context);
    final searchProv = Provider.of<LogSearchProvider>(context);

    if(searchProv.query != ""){//if(searchProv.query != null && searchProv.query!='') {
      return FutureBuilder(
      future: logProvider.getLogSearch(searchProv.query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        final LogResponse logSearch = snapshot.data as LogResponse;
        return Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(size.width*.02,0,size.width*.02,size.width*.02,),
            child: logSearch.bitacora.length > 0 ? 
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15
              ),
              itemCount: logSearch.bitacora.length,
              itemBuilder: (_,index){
                return GestureDetector(
                  onTap: () => {
                    
                    Navigator.pushNamed(context, 'viewlog', arguments: logSearch.bitacora[index])

                    //print(.description)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(logSearch.bitacora[index].description, style: const TextStyle(color: Colors.white, fontSize: 18.0),textAlign: TextAlign.center, overflow: TextOverflow.fade,),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 57, 99),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                );
              }
            )
            :
              Column(
               children: const [
                Icon(Icons.no_accounts),
                SizedBox(height: 20.0,),
                Text("NO SE HA ENCONTRADO NINGUN SERVICIO")
              ],
            )
          ),
        );
        
      },
    );
    }
    
     return FutureBuilder(
      future: logProvider.getLog(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Expanded(child: Center(child: CircularProgressIndicator(),));
        }
        final LogResponse logs = snapshot.data as LogResponse;
        return Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(size.width*.02,0,size.width*.02,size.width*.02,),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 4 / 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15
              ),
              itemCount: logs.bitacora.length,
              itemBuilder: (_,index){
                return GestureDetector(
                  onTap: () => {
                    
                    Navigator.pushNamed(context, 'viewlog', arguments: logs.bitacora[index])

                    //print(.description)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(logs.bitacora[index].description, style: const TextStyle(color: Colors.white, fontSize: 18.0),textAlign: TextAlign.center, overflow: TextOverflow.fade,),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 57, 99),
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                );
              }
            ),
          ),
        );
        
      },
    );
    
  }
}

