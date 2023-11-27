import 'package:flutter/material.dart';
import 'package:friend_findr/repository/UserRepository.dart';
import 'package:friend_findr/services/user_service.dart';

import '../models/User.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UserService? _userService;
  List? listUsers;
  late Future _future;
  TextEditingController resultController = TextEditingController();

  Future initialize() async{
    listUsers = await _userService?.getAll(10);
  }

  @override
  void initState() {
    _userService = UserService();
    _future = initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: listUsers!.length,
              itemBuilder: (BuildContext context, int index) {
                return UserItem(user:listUsers![index]);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  }
}

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});

  final User user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {

  bool _add=false;
  UserRepository? _userRepository;

  initialize() async{
    _add = await _userRepository?.isAdd(widget.user)??false;
    if (mounted){
      setState(() {
        _add = _add;
      });
    }
  }

  @override
  void initState() {
    _userRepository = UserRepository();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final image= CircleAvatar(
      backgroundImage: NetworkImage(widget.user.picture!.thumbnail!),
      radius: 40,
    );

    final myIcon= _add? const Icon(
      Icons.delete,color:Colors.orange,
    ):const Icon(
      Icons.favorite,color:Colors.grey,
    );


    return Card(
      child: ListTile(
        leading: image,
        title: Text(widget.user.name?.first != null ? widget.user.name!.first! : 'First name is not defined'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.user.name?.last != null ? widget.user.name!.last! : 'Last Name is not defined'),
            Text(widget.user.email != null ? widget.user.email! : 'Last Name is not defined'),
            Text(widget.user.cell != null ? widget.user.cell! : 'Cell is not defined'),
          ],
        ),
        trailing: IconButton(
          icon: myIcon,
          onPressed: (){
            setState(() {
              _add = !_add;
            });
            _add?
                _userRepository?.insert(widget.user)
            : _userRepository?.delete(widget.user);
          },
        ),
      ),
    );
  }
}

