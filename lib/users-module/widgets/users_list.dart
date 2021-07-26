import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tirmobile/shared/models/user.dart';

class UsersList extends StatelessWidget {
  final List<User> users;

  UsersList({@required this.users});

  @override
  Expanded build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) =>
            userTile(users[index]),
        separatorBuilder: (_, __) => Divider(),
      ),
    );
  }

  ListTile userTile(User users) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(users.id.toString()),
      ),
      title: Text(users.title),
      subtitle: Text(users.body),
    );
  }
}
