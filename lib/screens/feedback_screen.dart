import 'dart:io';

import 'package:app/models/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:app/providers/providers.dart';
import 'package:app/widgets/widgets.dart';

class FeedbackScreen extends StatelessWidget {
  Service arguments;
   FeedbackScreen({required this.arguments});

  @override
  Widget build(BuildContext context) {

    XFile? image;


    final feedbackProvider = Provider.of<FeedBackProvider>(context);
    
    return Scaffold(

      backgroundColor: Color.fromARGB(255, 4, 36, 133),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: feedbackProvider.feedbackKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  const CustomTitle(
                    text:'Descripción Real', 
                    color: Colors.white,
                  ),

                  _CustomFormFields(
                    initialValue: feedbackProvider.description,
                    onChange: (value) => feedbackProvider.description = value,
                  ),

                  const SizedBox(height: 20.0,),
                  
                  const CustomTitle(
                    text: 'Feedback al Usuario',
                    color: Colors.white,
                  ),

                  _CustomFormFields(
                    initialValue: feedbackProvider.feedBack,
                    onChange: (value) => feedbackProvider.feedBack = value,
                  ),
                  const SizedBox(height: 20.0,),

                  const CustomTitle(
                    text: 'Solución',
                    color: Colors.white,
                  ),

                  _CustomFormFields(
                    initialValue: feedbackProvider.solution,
                    onChange: (value) => feedbackProvider.solution = value,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20.0,),

                  const CustomTitle(
                    text: 'Dispositivo del Problema',
                    color: Colors.white,
                    size: 18,
                  ),

                  CheckboxListTile(
                    title: const CustomTitle(
                      text: 'Equipo Terminal',
                      color: Colors.white,
                    ),
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    value: feedbackProvider.isTerminalEquip,
                    onChanged: (value) => feedbackProvider.changeisTerminalEquip(value!),
                  ),

                  CheckboxListTile(
                    title: const CustomTitle(
                      text: 'Equipo de Red',
                      color: Colors.white,
                    ),
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    value: feedbackProvider.isNetworkEquip,
                    onChanged: (value) => feedbackProvider.changeIsNetworkEquip(value!),
                  ),
                  const SizedBox(height: 20.0,),

                 
                  // const CustomTitle(
                  //   text:'Personal Adicional',
                  //   color: Colors.white,
                  // ),

                  // FutureBuilder(
                  //   future: siteUProv.getSiteUsers(),
                  //   builder: (context,snapshot){
                  //     if (!snapshot.hasData) {
                  //       return const Center(child: CircularProgressIndicator(),);
                  //     }
                  //     else{
                  //       return const UserListSlider();
                  //     }
                  //   }
                    
                  // ),
                  
                  IconButton(onPressed: ()=>pickImage(feedbackProvider), 
                  color: feedbackProvider.isFile? Color.fromARGB(255, 0, 255, 8) : Colors.grey,
                  icon: const Icon(Icons.photo),),

                  Center(
                    child: MaterialButton(
                      onPressed: ()=>{
                        context.read<FeedBackProvider>().finalize(arguments, context),
                        Navigator.pop(context)}, 
                      color: Color.fromARGB(255, 0, 65, 119), 
                      child: const Icon(Icons.send, color: Colors.white),
                      )
                      ),

                ],
              
              )
            ),
          ),
        ),
      ),
    );
    
  }
}

Future pickImage(FeedBackProvider prov) async {
  XFile img = (await ImagePicker().pickImage(source: ImageSource.camera))!;
  prov.file = File(img.path);
  prov.fileExists(true);
}


class _CustomFormFields extends StatelessWidget {

  final int? maxLines;
  final void Function(String) onChange;
  final String initialValue;
  
  const _CustomFormFields({
    Key? key,
    this.maxLines,
    required this.initialValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChange,
      maxLines: maxLines ?? 5,
      decoration: const InputDecoration(
            
        fillColor: Colors.white,
        filled: true,

        enabledBorder: OutlineInputBorder(
          borderSide  : BorderSide(color: Color(0xffededed)),
        ),
            
        focusedBorder : OutlineInputBorder(
          borderSide  : BorderSide(color: Color(0xffededed))
        )
            
      ),
    );
  }
}