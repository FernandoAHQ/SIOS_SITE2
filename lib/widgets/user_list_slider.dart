import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/models.dart';

import 'package:app/providers/providers.dart';

class UserListSlider extends StatelessWidget {
  const UserListSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final userListProvider = Provider.of<UsersSiteProvider>(context).usuariosSite.users;
    
    return SizedBox(
      width: double.infinity,
      height: size.height *.15,

      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: userListProvider.length,
        itemBuilder: (_,int index) => _UserCircleAvatar(user: userListProvider[index],)
      ),
    );
  }
}

class _UserCircleAvatar extends StatelessWidget {

  const _UserCircleAvatar({
    Key? key,
    required this.user
  }) : super(key: key);

  final User user;
    
  @override
  Widget build(BuildContext context) {

    final feedbackProvider = Provider.of<FeedBackProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSelected = feedbackProvider.checkSelected(user.id);

    return GestureDetector(
      onTap: (){
        feedbackProvider.tap(user.id);
        // print(user.id);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: size.width*.2,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height*.1),
                child: Stack(
                  children: [
                    FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(user.image),
                    ),
                    if(isSelected)
                      Container(color: const Color.fromRGBO(0, 0, 0, 0.5),),
                      // Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Light_green_check.svg/2048px-Light_green_check.svg.png'))
                  ],
                ),
              ),
            ),
            FittedBox(
              child: Text(
                user.name
              )
            )
          ],
        ),
      ),
    );
  }
}